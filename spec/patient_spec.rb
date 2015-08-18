require('spec_helper')

describe(Patient) do
  describe('.all') do
    it('returns the empty list of patients') do
    expect(Patient.all()).to(eq([]))
    end
  end
  describe('#save') do
    it('it saves the patient to the patient table') do
      test_patient = Patient.new({:name => "bill", :birthday => "1960-01-31", :doctor_id => 1})
      test_patient.save()
      expect(Patient.all).to(eq([test_patient]))
    end
  end
  describe('#==') do
    it('is the same patient if it has the same description') do
    patient1 = Patient.new({:name => "bill", :birthday => "1960-01-31", :doctor_id => 1})
    patient2 = Patient.new({:name => "bill", :birthday => "1960-01-31", :doctor_id => 1})
    expect(patient1).to eq patient2
    end
  end
end
