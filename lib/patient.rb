# As an administrator, I want to add a doctor to the database with a name and specialty.
# As an administrator, I want to add a patient with their name and birthdate.
# As an administrator, I want to be able to assign a patient to a doctor for care. (Hint: Doctors will have a one-to-many relationship with their patients.)
# As a doctor, I want to see the list of patients that have been assigned to me.

class Patient
  attr_reader(:id, :name, :birthday, :doctor_id)

  define_method(:initialize) do |attributes|
  @name =       attributes.fetch(:name)
  @birthday =   attributes.fetch(:birthday)
  @doctor_id =  attributes[:doctor_id]
  @id =         attributes[:id]
  end
  define_singleton_method(:all) do
   returned_patient = DB.exec("SELECT * FROM patient;")
   patients = []
   returned_patient.each() do |patient|
     name = patient.fetch("name")
     id = patient.fetch("id").to_i
     birthday = patient.fetch("birthday")
     doctor_id = patient.fetch("doctor_id").to_i()
     patients.push(Patient.new({:name => name, :birthday => birthday, :doctor_id => doctor_id, :id => id}))
   end
   patients
  end
  define_method(:save) do
    if ! @doctor_id
      @doctor_id = "NULL"
    end
    result = DB.exec("INSERT INTO patient (name, birthday, doctor_id) VALUES ('#{@name}','#{@birthday}', #{@doctor_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end
  define_method(:==) do |another_patient|
    self.name.==(another_patient.name).&(self.doctor_id.==(another_patient.doctor_id)).&(self.birthday.==(another_patient.birthday)).&(self.id.==(another_patient.id))
  end
end
