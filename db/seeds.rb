# encoding : utf-8
require 'faker'

# Create specializations
specializations = [
  "General Surgeon",
  "Cardiologist",
  "Pediatrician",
  "Dermatologist",
  "Neurologist",
  "Orthopedic Surgeon",
  "Psychiatrist",
  "Gastroenterologist",
  "Oncologist",
  "ENT Specialist"
].map do |specialization|
  Specialization.find_or_create_by!(name: specialization)
end

# Create degrees
degrees = [
  "Doctor of Medicine (MD)",
  "Bachelor of Medicine, Bachelor of Surgery (MBBS)",
  "Master of Surgery (MS)",
  "Diplomate of National Board (DNB)",
  "Bachelor of Ayurvedic Medicine and Surgery (BAMS)",
  "Bachelor of Homoeopathic Medicine and Surgery (BHMS)",
  "Bachelor of Science in Nursing (B.Sc Nursing)",
  "Master of Science in Nursing (M.Sc Nursing)",
  "Doctor of Osteopathic Medicine (DO)",
  "Bachelor of Physiotherapy (BPT)"
].map do |degree|
  Degree.find_or_create_by!(name: degree)
end

# Create institutes
institutes = [
  "All India Institute of Medical Sciences (AIIMS)",
  "Christian Medical College (CMC), Vellore",
  "Armed Forces Medical College (AFMC), Pune",
  "Post Graduate Institute of Medical Education and Research (PGIMER), Chandigarh",
  "Jawaharlal Institute of Postgraduate Medical Education and Research (JIPMER), Puducherry",
  "King George's Medical University (KGMU), Lucknow",
  "Maulana Azad Medical College, Delhi",
  "Manipal University, Karnataka",
  "Kasturba Medical College, Manipal",
  "Banaras Hindu University (BHU), Varanasi",
  "Government Medical College, Mumbai",
  "Sanjay Gandhi Postgraduate Institute of Medical Sciences, Lucknow",
  "Lady Hardinge Medical College, Delhi",
  "Sri Ramachandra Institute of Higher Education and Research, Chennai",
  "Gujarat Cancer Research Institute, Ahmedabad",
  "Narayana Health, Bangalore",
  "Indira Gandhi Institute of Medical Sciences, Patna",
  "B.J. Medical College, Ahmedabad",
  "Bhopal Memorial Hospital and Research Centre, Bhopal",
  "National Institute of Mental Health and Neuro Sciences (NIMHANS), Bangalore"
].map do |institute|
  Institute.find_or_create_by!(name: institute)
end

# Create registration councils
registration_councils = [
  "Medical Council of India (MCI)",
  "Delhi Medical Council",
  "Maharashtra Medical Council",
  "Karnataka Medical Council",
  "Tamil Nadu Medical Council",
  "Gujarat Medical Council",
  "Uttar Pradesh Medical Council",
  "Andhra Pradesh Medical Council",
  "Kerala Medical Council",
  "West Bengal Medical Council"
].map do |council|
  RegistrationCouncil.find_or_create_by!(name: council)
end

# Create address for establishments and patients
address = Address.create!(
  address_line_1: Faker::Address.street_address,
  address_line_2: Faker::Address.secondary_address,
  city: Faker::Address.city,
  state: Faker::Address.state,
  country: "India",
  pin_code: Faker::Address.zip_code
)

# Create establishments and associate with address
establishment = Establishment.create!(
  name: Faker::Company.name,
  address_id: address.id,   # associate with address using address_id
  latitude: Faker::Address.latitude,
  longitude: Faker::Address.longitude,
  maps_location: "https://goo.gl/maps/#{Faker::Address.street_address.gsub(' ', '-')}"  # Example for a map location
)

# Create doctor profiles
doctor_profile = DoctorProfile.create!(
  name: Faker::Name.name,
  gender: ["Male", "Female"].sample,
  date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65),
  specialization: specializations.sample,
  degree: degrees.sample,
  institute: institutes.sample,
  year_of_completion: Faker::Number.between(from: 2000, to: 2022),
  year_of_experience: Faker::Number.between(from: 1, to: 20)
)

# Create doctor establishment association
DoctorEstablishment.create!(
  doctor_profile: doctor_profile,
  establishment: establishment
)

# Create patient profiles
patient_profile = PatientProfile.create!(
  name: Faker::Name.name,
  gender: ["Male", "Female"].sample,
  date_of_birth: Faker::Date.birthday(min_age: 0, max_age: 100),
  blood_group: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"].sample,
  address: address
)

# Create reviews for the doctor from patients
Review.create!(
  patient_profile: patient_profile,
  doctor_profile: doctor_profile
)

# Create services offered by the doctor at the establishment
Service.create!(
  doctor_profile: doctor_profile,
  establishment: establishment,
  name: "Consultation",
  day_of_week: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"].sample,
  start_time: DateTime.now.change({ hour: Faker::Number.between(from: 9, to: 11), min: 0 }),
  end_time: DateTime.now.change({ hour: Faker::Number.between(from: 12, to: 17), min: 0 }),
  slot_length_in_minutes: [15, 30, 45].sample,
  amount_cents: Faker::Number.between(from: 2000, to: 10000),  # Price in cents
  amount_currency: "INR"
)

# Create user associated with a patient profile
User.create!(
  email: Faker::Internet.email,
  password: "SecureP@ssw0rd4567!",  # This will automatically be encrypted by Devise
  password_confirmation: "SecureP@ssw0rd4567!",
  patient_profile: patient_profile,
  jti: SecureRandom.uuid
)

# Create user associated with a doctor profile
User.create!(
  email: Faker::Internet.email,
  password: "D0ct0rSecure@102024",  # This will automatically be encrypted by Devise
  password_confirmation: "D0ct0rSecure@102024",
  doctor_profile: doctor_profile,
  jti: SecureRandom.uuid
)

puts "Seeding completed Okay!"

