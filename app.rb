require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/patient')
require('./lib/doctor')
require('pg')

DB = PG.connect({:dbname => "doctor_office_test"})

get('/') do
  @doctors = Doctor.all()
  erb(:index)
end

post('/doctors') do
  name = params.fetch("name")
  specialty = params.fetch("specialty")
  doctor = Doctor.new({:name => name, :specialty => specialty, :id => nil})
  doctor.save()
  @doctors = Doctor.all
  erb(:doctor_success)
end
