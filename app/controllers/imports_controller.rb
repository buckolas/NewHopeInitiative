require 'csv'

class ImportsController < ApplicationController
  def create
    if params[:csvFile]
      n=0
      CSV.parse params[:csvFile].read do |row|
        @kibera_child = KiberaChild.new
        col = 0
        
        # New Hope Assessment information
        # SKIP Row 0 = the row number
        @kibera_child.assessment_documentation_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.first_name = row[col].strip if row[col+=1]
        @kibera_child.last_name = row[col].strip if row[col+=1]
        @kibera_child.grade = String.to_grade row[col+=1]
        
        if row[5].nil? && row[6] && @kibera_child.assessment_documentation_date
          # If there is not birthdate in the spreadsheet, use the age and assessment date if available to make a guess
          age = row[6].to_i
          @kibera_child.birth_date = Date.new(@kibera_child.assessment_documentation_date.year - age, @kibera_child.assessment_documentation_date.month, @kibera_child.assessment_documentation_date.day)
        else
          @kibera_child.birth_date = Date.parse(row[5], true) rescue Date.today
        end
        
        col = 6
        @kibera_child.gender = String.to_gender row[col+=1]
        @kibera_child.orphan = String.to_orphan row[col+=1]
        @kibera_child.name_of_parent_or_guardian = row[col] if row[col+=1]
        @kibera_child.height_in_cm = row[col] if row[col+=1]
        # SKIP Row 10 Height in inches
        # SKIP Row 11 Height in feet/inches
        col+=2
        @kibera_child.weight_in_kg = row[col] if row[col+=1]
        # SKIP Row 13 = Weight in pounds
        col+=1
        @kibera_child.uam_in_cm = row[col] if row[col+=1]
        # SKIP Row 15 = UAM in inches
        col+=1
        @kibera_child.assessment_temperature_in_fahrenheit = row[col] if row[col+=1]
        @kibera_child.blood_pressure_systolic = row[col].split("/")[0] if row[col+=1] && row[col].include?("/")
        @kibera_child.blood_pressure_diastolic = row[col].split("/")[1] if row[col] && row[col].include?("/")
        @kibera_child.has_hearing_complaints = String.to_bool row[col+=1]
        @kibera_child.vision_right = row[col] if row[col+=1]
        @kibera_child.vision_left = row[col] if row[col+=1]
        @kibera_child.has_cavities = String.to_bool row[col+=1]
        @kibera_child.has_teeth_missing = String.to_bool row[col+=1]
        @kibera_child.has_healthy_tongue = String.to_bool row[col+=1]
        @kibera_child.has_red_patches = String.to_bool row[col+=1]
        @kibera_child.has_evidence_of_yeast = String.to_bool row[col+=1]
        @kibera_child.has_big_belly = String.to_bool row[col+=1]
        @kibera_child.has_swollen_feet = String.to_bool row[col+=1]
        @kibera_child.has_thin_arms_or_legs = String.to_bool row[col+=1]
        @kibera_child.has_hair_loss = String.to_bool row[col+=1]
        @kibera_child.has_mouth_sores = String.to_bool row[col+=1]
        @kibera_child.has_scalp_fungus = String.to_bool row[col+=1]
        @kibera_child.has_dry_skin = String.to_bool row[col+=1]
        @kibera_child.has_rashes = String.to_bool row[col+=1]
        @kibera_child.rash_location = row[34] if row[col+=1]
        @kibera_child.has_had_tb = String.to_bool row[col+=1]
        @kibera_child.tb_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.has_tb_treatment_completed = String.to_bool row[col+=1]
        @kibera_child.has_had_typhoid = String.to_bool row[col+=1]
        @kibera_child.typhoid_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.has_had_malaria = String.to_bool row[col+=1]
        @kibera_child.malaria_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.has_menstruated = String.to_bool row[col+=1]
        @kibera_child.has_received_menstrual_products = String.to_bool row[col+=1]
        @kibera_child.menstrual_products_distribution_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.has_menstrual_product_access = String.to_bool row[col+=1]
        @kibera_child.has_toothbrush = String.to_bool row[col+=1]
        @kibera_child.has_toothpaste = String.to_bool row[col+=1]
        @kibera_child.has_soap = String.to_bool row[col+=1]
        @kibera_child.hygenall_products_distribution_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.sleeping_location = String.to_sleeping_location row[col+=1]
        @kibera_child.sleeps_with_mosquito_net = row[col] if row[col+=1]
        @kibera_child.has_bible = String.to_bool row[col+=1]
        @kibera_child.is_christian = String.to_bool row[col+=1]
        @kibera_child.is_attending_church = String.to_bool row[col+=1]
        @kibera_child.church_location = row[col] if row[col+=1]
        @kibera_child.favorite_color = row[col] if row[col+=1]
        @kibera_child.meals_eaten_per_day = row[col] if row[col+=1]
        @kibera_child.has_food_available_at_home = String.to_bool row[col+=1]
        @kibera_child.is_food_prepared_with_charcoal = String.to_bool row[col+=1]
        @kibera_child.has_windows_in_home = String.to_bool row[col+=1]
        @kibera_child.has_school_uniform = String.to_bool row[col+=1]
        @kibera_child.is_school_uniform_in_good_condition = String.to_bool row[col+=1]
        @kibera_child.state_of_school_uniform = row[col] if row[col+=1]
        @kibera_child.dress_size = row[col] if row[col+=1]
        @kibera_child.shirt_size = row[col] if row[col+=1]
        @kibera_child.shorts_size = row[col] if row[col+=1]
        @kibera_child.has_shoes = String.to_bool row[col+=1]
        @kibera_child.is_shoes_in_good_condition = String.to_bool row[col+=1]
        @kibera_child.shoe_size = row[col] if row[col+=1]
        @kibera_child.additional_comments = row[col] if row[col+=1]
          
        # Physical Exam information
        @kibera_child.physical_examination_date = Date.parse(row[col+=1], true) rescue Date.today
        @kibera_child.physical_examination_temperature_in_celsius = row[col] if row[col+=1]
        @kibera_child.health_notes = row[col] if row[col+=1]
        @kibera_child.observations = row[col] if row[col+=1]
        @kibera_child.recommendations = row[col] if row[col+=1]
        @kibera_child.is_antibiotics_needed = String.to_bool row[col+=1]
        @kibera_child.is_antihistamines_needed = String.to_bool row[col+=1]
        @kibera_child.is_antifungals_needed = String.to_bool row[col+=1]
        @kibera_child.is_vitamins_needed = String.to_bool row[col+=1]
        @kibera_child.is_ear_syringing_needed = String.to_bool row[col+=1]
        @kibera_child.is_deworming_needed = String.to_bool row[col+=1]
        @kibera_child.is_stool_sample_needed = String.to_bool row[col+=1]
        @kibera_child.is_dental_attention_needed = String.to_bool row[col+=1]
        @kibera_child.is_opthamologist_needed = String.to_bool row[col+=1]
        @kibera_child.is_pain_killers_needed = String.to_bool row[col+=1]
        @kibera_child.is_blood_test_needed = String.to_bool row[col+=1]
        @kibera_child.is_washing_needed = String.to_bool row[col+=1]
        @kibera_child.has_umbilical_hernia = String.to_bool row[col+=1]
        @kibera_child.additional_physical_examination_notes = row[col] if row[col+=1]
         
        if @kibera_child.save
          n=n+1
          GC.start if n % 50 == 0
        end
        flash.now[:message] = "CSV Import Successful, #{n} new children added."
      end
      redirect_to kibera_children_path
    else
      flash.now[:message] = "No file selected."
      render :action => "new"
    end
  end
  
end