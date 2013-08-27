class CreateSpecialities < ActiveRecord::Migration
  def change
    create_table :specialities do |t|
      t.string :name

      t.timestamps
    end
    Speciality.create(name: "Family Medicine")    
    Speciality.create(name: "OBGYN")    
    Speciality.create(name: "Internal Medicine")  
    Speciality.create(name: "Pediatrics")  
    Speciality.create(name: "Inpatient")  
    Speciality.create(name: "Ambulatory")
    
    # Speciality.create(name: "Cardiology")  
    # Speciality.create(name: "Ophthalmology")  
    # Speciality.create(name: "Surgery")  
    # Speciality.create(name: "Colon/Rectal Surgery")  
    # Speciality.create(name: "Neuro Surgery")  
    # Speciality.create(name: "Orthopaedic Surgery")  
    # Speciality.create(name: "Plastic Surgery")  
    # Speciality.create(name: "Cardiac Surgery")  
    # Speciality.create(name: "Otolaryngology")  
    # Speciality.create(name: "Pathology")  
    # Speciality.create(name: "Rehabilitation")  
    # Speciality.create(name: "Radiology")  
    # Speciality.create(name: "Urology")  
    # Speciality.create(name: "Emergency Medicine")  
    # Speciality.create(name: "Dermotology")  
    # Speciality.create(name: "Allergy/Immunology")  
    # Speciality.create(name: "Anesthesiology")  
    # Speciality.create(name: "Preventative Medicine")  
    # Speciality.create(name: "Occupational Medicine")  
    # Speciality.create(name: "Oncology")  
    # Speciality.create(name: "Transplant")  
    # Speciality.create(name: "Gastroenterology")  
    # Speciality.create(name: "Geriatric Medicine")  
    # Speciality.create(name: "Palliative Care")  
    # Speciality.create(name: "Pulmonology")  
    # Speciality.create(name: "Nephrology")  
    # Speciality.create(name: "Sports Medicine")  
    # Speciality.create(name: "Sleep Medicine")  
    # Speciality.create(name: "Pain Medicine")  
    # Speciality.create(name: "Endocrinology")  
    # Speciality.create(name: "Infectious Disease")  
  end
end
