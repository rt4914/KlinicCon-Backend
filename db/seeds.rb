# frozen_string_literal: true
require 'faker'

specializations = [
  'General Surgeon',
  'Cardiologist',
  'Pediatrician',
  'Dermatologist',
  'Neurologist',
  'Orthopedic Surgeon',
  'Psychiatrist',
  'Gastroenterologist',
  'Oncologist',
  'ENT Specialist'
]

degrees = [
  'Doctor of Medicine (MD)',
  'Bachelor of Medicine, Bachelor of Surgery (MBBS)',
  'Master of Surgery (MS)',
  'Diplomate of National Board (DNB)',
  'Bachelor of Ayurvedic Medicine and Surgery (BAMS)',
  'Bachelor of Homoeopathic Medicine and Surgery (BHMS)',
  'Bachelor of Science in Nursing (B.Sc Nursing)',
  'Master of Science in Nursing (M.Sc Nursing)',
  'Doctor of Osteopathic Medicine (DO)',
  'Bachelor of Physiotherapy (BPT)'
]

institutes = [
  'All India Institute of Medical Sciences (AIIMS)',
  'Christian Medical College (CMC), Vellore',
  'Armed Forces Medical College (AFMC), Pune',
  'Post Graduate Institute of Medical Education and Research (PGIMER), Chandigarh',
  'Jawaharlal Institute of Postgraduate Medical Education and Research (JIPMER), Puducherry',
  'King George&#39;s Medical University (KGMU), Lucknow',
  'Maulana Azad Medical College, Delhi',
  'Manipal University, Karnataka',
  'Kasturba Medical College, Manipal',
  'Banaras Hindu University (BHU), Varanasi',
  'Government Medical College, Mumbai',
  'Sanjay Gandhi Postgraduate Institute of Medical Sciences, Lucknow',
  'Lady Hardinge Medical College, Delhi',
  'Sri Ramachandra Institute of Higher Education and Research, Chennai',
  'Gujarat Cancer Research Institute, Ahmedabad',
  'Narayana Health, Bangalore',
  'Indira Gandhi Institute of Medical Sciences, Patna',
  'B.J. Medical College, Ahmedabad',
  'Bhopal Memorial Hospital and Research Centre, Bhopal',
  'National Institute of Mental Health and Neuro Sciences (NIMHANS), Bangalore'
]

councils = [
  'Medical Council of India (MCI)',
  'Delhi Medical Council',
  'Maharashtra Medical Council',
  'Karnataka Medical Council',
  'Tamil Nadu Medical Council',
  'Gujarat Medical Council',
  'Uttar Pradesh Medical Council',
  'Andhra Pradesh Medical Council',
  'Kerala Medical Council',
  'West Bengal Medical Council'
]

cities = [
"Mumbai", "Delhi", "Bangalore", "Hyderabad", "Ahmedabad", "Chennai",
  "Kolkata", "Surat", "Pune", "Jaipur", "Lucknow", "Kanpur", "Nagpur",
  "Indore", "Thane", "Bhopal", "Visakhapatnam", "Patna", "Vadodara", 
  "Ghaziabad", "Ludhiana", "Agra", "Nashik", "Faridabad", "Meerut", 
  "Rajkot", "Kalyan-Dombivli", "Vasai-Virar", "Varanasi", "Srinagar", 
  "Aurangabad", "Dhanbad", "Amritsar", "Navi Mumbai", "Allahabad", 
  "Howrah", "Ranchi", "Gwalior", "Jabalpur", "Coimbatore", "Vijayawada", 
  "Jodhpur", "Madurai", "Raipur", "Kota", "Guwahati", "Chandigarh", 
  "Solapur", "Hubli–Dharwad", "Mysore", "Tiruchirappalli", "Bareilly", 
  "Aligarh", "Tiruppur", "Moradabad", "Jalandhar", "Bhubaneswar", 
  "Salem", "Warangal", "Guntur", "Bhiwandi", "Saharanpur", "Gorakhpur", 
  "Bikaner", "Amravati", "Noida", "Jamshedpur", "Bhilai", "Cuttack", 
  "Firozabad", "Kochi", "Nellore", "Bhavnagar", "Dehradun", "Durgapur", 
  "Asansol", "Rourkela", "Nanded", "Kolhapur", "Ajmer", "Akola"
]

degrees.each { |name| Degree.find_or_create_by!(name: name) }

specializations.each { |name| Specialization.find_or_create_by!(name: name) }

institutes.each { |name| Institute.find_or_create_by!(name: name) }

councils.each { |name| RegistrationCouncil.find_or_create_by!(name: name) }

addresses = Array.new(40) do
  Address.create!(
    address_line_1: Faker::Address.street_address,
    address_line_2: Faker::Address.secondary_address,
    city: Faker::Address.city,
    state: Faker::Address.state,
    country: 'India',
    pin_code: Faker::Address.zip_code
  )
end

establishments = Array.new(20) do |index|
  Establishment.create!(
    name: Faker::Company.name,
    address_id: addresses[index].id,
    city: cities.sample,
    latitude: Faker::Address.latitude,
    longitude: Faker::Address.longitude,
    maps_location: "https://goo.gl/maps/#{Faker::Address.street_address.gsub(' ', '-')}"
  )
end

doctor_profiles = Array.new(20) do
  year_of_completion = Faker::Number.between(from: 2000, to: 2022)
  DoctorProfile.create!(
    name: Faker::Name.name,
    gender: %w[Male Female].sample,
    date_of_birth: Faker::Date.birthday(min_age: 25, max_age: 65),
    specialization: Specialization.all.sample,
    degree: Degree.all.sample,
    institute: Institute.all.sample,
    year_of_completion: year_of_completion,
    year_of_experience: Date.current.year - year_of_completion
  ).tap do |doctor_profile|
    DoctorEstablishment.create!(
      doctor_profile: doctor_profile,
      establishment: establishments.sample
    )
  end
end

patient_profiles = Array.new(50) do
  PatientProfile.create!(
    name: Faker::Name.name,
    gender: %w[Male Female].sample,
    date_of_birth: Faker::Date.birthday(min_age: 0, max_age: 100),
    blood_group: %w[A+ A- B+ B- O+ O- AB+ AB-].sample,
    address: addresses.sample
  )
end

# TODO: Review model should contain rating and comment. This is missing currently.
# Once that is fixed we should add fake data too.

# Faker::Number.between(from: 20, to: 50).times do
#   Review.create!(
#     patient_profile: patient_profiles.sample,
#     doctor_profile: doctor_profiles.sample
#   )
# end

Faker::Number.between(from: 20, to: 50).times do
  Service.create!(
    doctor_profile: doctor_profiles.sample,
    establishment: establishments.sample,
    name: 'Consultation',
    day_of_week: %w[Monday Tuesday Wednesday Thursday Friday Saturday].sample,
    start_time: DateTime.now.change(hour: Faker::Number.between(from: 9, to: 11), min: 0),
    end_time: DateTime.now.change(hour: Faker::Number.between(from: 12, to: 17), min: 0),
    slot_length_in_minutes: [15, 30, 45].sample,
    amount_cents: Faker::Number.between(from: 2000, to: 10_000),
    amount_currency: 'INR'
  )
end

patient_profiles.each do |patient_profile|
  User.create!(
    email: "patient#{patient_profile.id}@gmail.com",
    password: 'newtest@321',
    password_confirmation: 'newtest@321',
    patient_profile: patient_profile,
    jti: SecureRandom.uuid
  )
end

doctor_profiles.each do |doctor_profile|
  User.create!(
    email: "doctor#{doctor_profile.id}@gmail.com",
    password: 'newtest@321',
    password_confirmation: 'newtest@321',
    doctor_profile: doctor_profile,
    jti: SecureRandom.uuid
  )
end