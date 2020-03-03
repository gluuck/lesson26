# Language: Ruby, Level: Level 3
#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require "sqlite3"
configure do
	db = get_db
	db.execute 'CREATE TABLE if not exists "Users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT, "name" text, "phone" text ,"datestamp" text,"barber" text,"color" text);'
end

get '/' do
	erb "Hello! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School!!!</a>"
end
get '/about'do
	@error = "somethings"
	erb :about
end
get '/visit' do
	erb :visit
end
get '/contacts' do
	erb :contacts
end

post '/visit'do
	@name = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]
	hh ={:username=>'Введите имя',:phone=>'Введите номер телефона',:datetime=>'Выберите дату и время'}
	@error=hh.select{|key,_| params[key]==''}.values.join(", ")
	if @error !=''
			return erb :visit
	end

		db=get_db
	  db.execute ('insert into Users (name,phone,datestamp,barber,color) values (?,?,?,?,?)'),
	  [@name , @phone,@datetime,@barber,@color]


		erb "Name: #{@name}, phone number: #{@phone}, your date and time #{@datetime}, your master: #{@barber} color: #{@color}"

end
get	'/showusers' do


end
def get_db
	db = SQLite3::Database.new 'barbershop.db'
	db.results_as_hash = true
	return db
end
