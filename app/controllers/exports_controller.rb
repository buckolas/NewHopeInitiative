if RUBY_VERSION < "1.9"
require "rubygems"
require "faster_csv"
CSV = FCSV
else
require "csv"
end

class ExportsController < ApplicationController
  def index
    @children = KiberaChild.find_children(session[:search], session[:grade])
    n=0


    csv_string = CSV.generate do |csv|
      # header row
      csv << ["Child #", "Assessment Date", "First Name", "Last Name", "Grade", "Birth Date", "Age", "Gender", "Orphan", "Name of Parent/Guardian", "Height (cm)", "Height (in)", "Height (ft/in)", "Weight (kg)", "Weight (lbs)", "UAM (cm)", "UAM (in)", "Temperature at Assessment (F)", "Blood Pressure (Systolic/Diastolic)", "Hearing Complaints?", "Vision (Right Eye)", "Vision (Left Eye)", "Cavities?", "Missing Teeth?", "Healthy Tongue?", "Red Patches?", "Evidence of Yeast?", "Big Belly", "Swollen Feet?", "Thin Arms/Legs?", "Loss of Hair?", "Mouth Sores?", "Scalp Fungus?", "Dry Skin?", "Rashes?", "Rash Location", "Had TB?", "TB Date", "HTB Treatment Completed?", "Had Typhoid", "Typhoid Date", "Had Malaria?", "Malaria Date", "Menstruated?", "Given Menstrual Products?", "Distribution Date", "Access to Menstrual Products?", "Toothbrush?", "Toothpaste?", "Soap?", "Distribution Date", "Sleeping Location", "Mosquito Net?", "Bible?", "Christian?", "Attends Church?", "Location", "Favorite Color", "Meals Eaten per Day", "Food Available at Home?", "Food Prepared With Charcoal?", "Windows In Home?", "School Uniform?", "In Good Condition?", "State of School Uniform", "Dress Size", "Shirt Size", "Shorts Size", "Shoes?", "In Good Condition?", "Shoe Size", "Additional Comments", "Physical Examination Date", "Temperature at Physical Examination  (C)", "Health Notes", "Observations", "Recommendations", "Needs Antibiotics?", "Needs Antihistamines?", "Needs Antifungals?", "Needs Vitamins?", "Needs Ear Syringing?", "Needs Deworming?", "Needs Stool Sample?", "Needs Dental Attention?", "Needs Opthamologist?", "Needs Pain Killers?", "Needs Blood Test?", "Needs Washing?", "Has Umbilical Hernia?", "Additional Notes"]


      # data rows
      @children.each do |child|
        csv << [n+=1, child.assessment_documentation_date, child.first_name, child.last_name, child.grade, child.birth_date, child.age, child.gender, child.orphan, child.name_of_parent_or_guardian, child.height_in_cm, child.height_in_cm ? child.height_in_cm * 0.39 : nil, child.height_in_cm ? ((child.height_in_cm * 0.39/12).floor.to_s + '\' ' + (child.height_in_cm * 0.39 % 12).floor.to_s + '"') : nil, child.weight_in_kg, child.weight_in_kg ? child.weight_in_kg * 2.2 : nil, child.uam_in_cm, child.uam_in_cm ? child.uam_in_cm * 0.39 : nil, child.assessment_temperature_in_fahrenheit, (child.blood_pressure_systolic && child.blood_pressure_diastolic) ? child.blood_pressure_systolic + '/' + child.blood_pressure_diastolic : nil, child.has_hearing_complaints, child.vision_right, child.vision_left, child.has_cavities, child.has_teeth_missing, child.has_healthy_tongue, child.has_red_patches, child.has_evidence_of_yeast, child.has_big_belly, child.has_swollen_feet, child.has_thin_arms_or_legs, child.has_hair_loss, child.has_mouth_sores, child.has_scalp_fungus, child.has_dry_skin, child.has_rashes, child.rash_location, child.has_had_tb, child.tb_date, child.has_tb_treatment_completed, child.has_had_typhoid, child.typhoid_date, child.has_had_malaria, child.malaria_date, child.has_menstruated, child.has_received_menstrual_products, child.menstrual_products_distribution_date, child.has_menstrual_product_access, child.has_toothbrush, child.has_toothpaste, child.has_soap, child.hygenall_products_distribution_date, child.sleeping_location, child.sleeps_with_mosquito_net, child.has_bible, child.is_christian, child.is_attending_church, child.church_location, child.favorite_color, child.meals_eaten_per_day, child.has_food_available_at_home, child.is_food_prepared_with_charcoal, child.has_windows_in_home, child.has_school_uniform, child.is_school_uniform_in_good_condition, child.state_of_school_uniform, child.dress_size, child.shirt_size, child.shorts_size, child.has_shoes, child.is_shoes_in_good_condition, child.shoe_size, child.additional_comments, child.physical_examination_date, child.physical_examination_temperature_in_celsius, child.health_notes, child.observations, child.recommendations, child.is_antibiotics_needed, child.is_antihistamines_needed, child.is_antifungals_needed, child.is_vitamins_needed, child.is_ear_syringing_needed, child.is_deworming_needed, child.is_stool_sample_needed, child.is_dental_attention_needed, child.is_opthamologist_needed, child.is_pain_killers_needed, child.is_blood_test_needed, child.is_washing_needed, child.has_umbilical_hernia, child.additional_physical_examination_notes]
          n+=1

      end
    end

    # send it to the user
    send_data csv_string, :type => 'text/csv; charset=iso-8859-1; header=present', :disposition => "attachment; filename=kibera_children.csv"
  end
end