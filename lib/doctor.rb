class Doctor

  attr_reader(:id, :name, :specialty)

  define_method(:initialize) do |attributes|
  @name =       attributes.fetch(:name)
  @specialty =  attributes.fetch(:specialty)
  @id =         attributes.fetch(:id)
  end
  define_singleton_method(:all) do
    returned_doctors = DB.exec("SELECT * FROM doctor;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      specialty = doctor.fetch("specialty")
      id = doctor.fetch("id").to_i()
      doctors.push(Doctor.new({:name => name, :specialty => specialty, :id => id}))
      end
      doctors
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO doctor(name, specialty) VALUES ('#{@name}', '#{@specialty}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |another_doctor|
    self.name.==(another_doctor.name).&(self.specialty.==(another_doctor.specialty)).&(self.id.==(another_doctor.id))
  end

  define_singleton_method(:find) do |id|
    found_doctor = nil

    Doctor.all().each() do |doctor|
      if doctor.id().==(id)
        found_doctor = doctor
      end
    end
    found_doctor
  end

  define_method(:patients) do
    returned_patients = DB.exec("SELECT * FROM patient WHERE doctor_id = #{@id}")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch('name')
      birthday = patient.fetch('birthday')
      id = patient.fetch('id').to_i()
      doctor_id = patient.fetch('doctor_id').to_i()
      patients.push(Task.new({:id => id, :name => name, :birthday => birthday, :doctor_id => doctor_id}))
    end
    patients
  end
end
