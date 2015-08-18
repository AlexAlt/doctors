require('spec_helper')

describe(Doctor) do
  describe('.all') do
    it('returns all of the doctors in the table') do
      expect(Doctor.all).to(eq([]))
    end
  end

  describe('#save') do
    it('saves a doctor to the database') do
      test_doctor = Doctor.new({:name => "bill", :specialty => "proctologist", :id => nil})
      test_doctor.save()
      expect(Doctor.all()).to(eq([test_doctor]))
    end
  end

  describe('#id') do
    it('sets its ID when you save it') do
    test_doctor = Doctor.new({:name => "bill", :specialty => "proctologist", :id => nil})
    test_doctor.save()
    expect(test_doctor.id()).to(be_an_instance_of(Fixnum))
    end
  end

  describe('#==') do
    it('is the same doctor if it has the same description') do
      test_doctor1 = Doctor.new({:name => "bill", :specialty => "proctologist", :id => nil})
      test_doctor2 = Doctor.new({:name => "bill", :specialty => "proctologist", :id => nil})
      expect(test_doctor1).to eq test_doctor2
    end
  end

  describe('.find') do
    it('finds the list by its ID') do
      test_doctor = Doctor.new(:name => "bill", :specialty => "proctologist", :id => nil)
      test_doctor.save()
      test_doctor2 = Doctor.new(:name => "lucy", :specialty => "proctologist", :id => nil)
      test_doctor2.save()
      expect(Doctor.find(test_doctor2.id)).to(eq(test_doctor2))
    end
  end

  describe('#patients') do
    it('returns all of the patients for the doctors') do
      test_doctor = Doctor.new(:name => "bill", :specialty => "proctologist", :id => nil)
      test_doctor.save()
      expect(test_doctor.patients()).to(eq([]))
    end
  end
end
