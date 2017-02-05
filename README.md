# README
(simple installation example)

## Generate new Rails 5 app with PostgresQL
```
rails new paperlab -d postgresql -T -B
cd paperlab
rvm --ruby-version use 2.3.3@paperlab --create
```
### Gemfile
```
gem 'slim'
gem 'paperclip', '~> 5.0.0'
```
### Bundler
```
gem install bundler --no-ri --no-rdoc
bundler
```
### /config/database.yml
```
cd config
cp database.yml database_sample.yml
```
### .gitignore
```
/config/database.yml
```

### Git
```
git init
git add .
git ci -m init project
git remote add origin git@github.com:MyAccount/paperlab.git
git push -u origin master
```
## Generate resource Course
```
rails g resource Course name:string
```
### DB
`rake db:migrate`

### Edit routes
```
root 'courses#index'
resources :courses, except: :show
```
### Create simple Conroller and Views for Course (see the code)

## Generate resource Material
```
rails g resource Material course:references
```
### Edit routes
```
resources :courses, except: :show do
  resources :materials, except: :show
end
```
### Course model
`has_many :materials, dependent: :destroy`

## Generate Paperclip
[Paperclip](https://github.com/thoughtbot/paperclip)

`rails g paperclip material file`

### DB
`rake db:migrate`

### Material model
```
has_attached_file :file, styles: { thumb: "100x>" }
do_not_validate_attachment_file_type :file
```
### Create simple Conroller and Views for Material (see code)

### Edit routes
```
resources :courses, except: :show do
  resources :materials, except: :show
  patch :duplicate
end
```
## Generate job (Active Job)
`rails g job course_duplication`

### Course model
```
def duplicate
  CourseDuplicationJob.perform_now(self)
end
```

### Courses controller
```
def duplicate
  @course = Course.find(params[:course_id])
  job = @course.duplicate
  flash[:notice] = "Task with job ID #{job} for course duplication add to workers queue"
  redirect_to courses_url
end
```
### Add link to Course index view
`td= link_to 'Duplicate', course_duplicate_path(course), method: :patch`

## Sidekiq

[Sidekiq](https://github.com/mperham/sidekiq)

### Gemfile + Bundler
`gem 'sidekiq'`

### PLug adapter sidekiq into /config/application.rb
`config.active_job.queue_adapter = :sidekiq`

### Run job later in Course model
```
job = CourseDuplicationJob.perform_later(self)
job.provider_job_id
```
## Redis server

[Redis](https://redis.io/)

`sudo apt-get install redis-server`

### .gitignore
```
dump.rdb
/public/system/
```
## Foreman

[Foreman](https://github.com/ddollar/foreman)

`gem install foreman`

### /procfile
```
rails: PORT=3000 rails s -b0
redis: redis-server
sidekiq: sidekiq
```

## run servers
`foreman start`
