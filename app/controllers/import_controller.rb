require 'csv'

class ImportController < ApplicationController
  def create
    if params[:csvFile]
      csvFile = params[:csvFile]
      parsedCSVFile = CSV::Reader.parse(csvFile)
      n=0
      parsedCSVFile.each  do |row|
         @kibera_child = KiberaChild.new
         
         # TODO: figure out how I am going to get the image in here
         # @kibera_child.image = row[1]
         
         @kibera_child.assessment_documentation_date = row[1]
         
         @kibera_child.first_name = row[2]
         @kibera_child.last_name = row[3]
         @kibera_child.age = row[5]
         @kibera_child.gender = row[6]
         
=begin
         @kibera_child.birth_date = row[1]
         @kibera_child.orphan = row[1]
         @kibera_child.name_of_parent_or_guardian = row[1]
         @kibera_child.height_in_cm = row[1]
         @kibera_child.weight_in_kg = row[1]
         @kibera_child.uam_in_cm = row[1]
         @kibera_child.assessment_temperature_in_fahrenheit = row[1]
         @kibera_child.blood_pressure_systolic = row[1]
         @kibera_child.blood_pressure_diastolic = row[1]
         @kibera_child.has_hearing_complaints = row[1]
         @kibera_child.vision_right = row[1]
         @kibera_child.vision_left = row[1]
         @kibera_child.has_cavities = row[1]
         @kibera_child.has_teeth_missing = row[1]
         @kibera_child.has_healthy_tongue = row[1]
         @kibera_child.has_red_patches = row[1]
         @kibera_child.has_evidence_of_yeast = row[1]
         @kibera_child.has_big_belly = row[1]
         @kibera_child.has_swollen_feet = row[1]
         @kibera_child.has_thin_arms_or_legs = row[1]
         @kibera_child.has_hair_loss = row[1]
         @kibera_child.has_mouth_sores = row[1]
         @kibera_child.has_scalp_fungus = row[1]
         @kibera_child.has_dry_skin = row[1]
         @kibera_child.has_rashes = row[1]
         @kibera_child.rash_location = row[1]
         @kibera_child.has_had_tb = row[1]
         @kibera_child.tb_date = row[1]
         @kibera_child.has_tb_treatment_completed = row[1]
         @kibera_child.has_had_typhoid = row[1]
         @kibera_child.typhoid_date = row[1]
         @kibera_child.has_had_malaria = row[1]
         @kibera_child.malaria_date = row[1]
         @kibera_child.has_menstruated = row[1]
         @kibera_child.has_received_menstrual_products = row[1]
         @kibera_child.menstrual_products_distribution_date = row[1]
         @kibera_child.has_menstrual_product_access = row[1]
         @kibera_child.has_toothbrush = row[1]
         @kibera_child.has_toothpaste = row[1]
         @kibera_child.has_soap = row[1]
         @kibera_child.hygenall_products_distribution_date = row[1]
         @kibera_child.sleeping_location = row[1]
         @kibera_child.sleeps_with_mosquito_net = row[1]
         @kibera_child.has_bible = row[1]
         @kibera_child.is_christian = row[1]
         @kibera_child.is_attending_church = row[1]
         @kibera_child.church_location = row[1]
         @kibera_child.favorite_color = row[1]
         @kibera_child.meals_eaten_per_day = row[1]
         @kibera_child.has_food_available_at_home = row[1]
         @kibera_child.is_food_prepared_with_charcoal = row[1]
         @kibera_child.has_windows_in_home = row[1]
         @kibera_child.has_school_uniform = row[1]
         @kibera_child.is_school_uniform_in_good_condition = row[1]
         @kibera_child.state_of_school_uniform = row[1]
         @kibera_child.dress_size = row[1]
         @kibera_child.shirt_size = row[1]
         @kibera_child.shorts_size = row[1]
         @kibera_child.has_shoes = row[1]
         @kibera_child.is_shoes_in_good_condition = row[1]
         @kibera_child.shoe_size = row[1]
         @kibera_child.additional_comments = row[1]
         @kibera_child.physical_examination_date = row[1]
         @kibera_child.physical_examination_temperature_in_celsius = row[1]
         @kibera_child.health_notes = row[1]
         @kibera_child.general_appearance = row[1]
         @kibera_child.is_antibiotics_needed = row[1]
         @kibera_child.is_antihistamines_needed = row[1]
         @kibera_child.is_antifungals_needed = row[1]
         @kibera_child.is_vitamins_needed = row[1]
         @kibera_child.is_ear_syringing_needed = row[1]
         @kibera_child.is_deworming_needed = row[1]
         @kibera_child.is_stool_sample_needed = row[1]
         @kibera_child.is_dental_attention_needed = row[1]
         @kibera_child.is_opthamologist_needed = row[1]
         @kibera_child.is_pain_killers_needed = row[1]
         @kibera_child.is_blood_test_needed = row[1]
         @kibera_child.is_washing_needed = row[1]
         @kibera_child.has_umbilical_hernia = row[1]
         @kibera_child.additional_physical_examination_notes = row[1]
=end
         
         if @kibera_child.save
            n=n+1
            GC.start if n % 50 == 0
         end
         flash.now[:message] = "CSV Import Successful,  #{n} new children added."
      end
      redirect_to kibera_children_path
    else
      flash.now[:message] = "No file selected."
      render :action => "new"
    end
  end
end
