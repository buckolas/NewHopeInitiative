require 'csv'

class ImportController < ApplicationController
  def create
    if params[:csvFile]
      csvFile = params[:csvFile]
      parsedCSVFile = CSV::Reader.parse(csvFile)
      n=0
      parsedCSVFile.each do |row|
        @kibera_child = KiberaChild.new

        # New Hope Assessment information
        # SKIP Row 0 = the row number
        @kibera_child.class_in_school = "pre"
        @kibera_child.assessment_documentation_date = row[1]
        @kibera_child.first_name = row[2]
        @kibera_child.last_name = row[3]
        # Row 4 = Y/N if a photo exists
        # @kibera_child.image = row[4]
        # @kibera_child.birth_date = row[X] no birth date column
        @kibera_child.age = row[5]
        @kibera_child.gender = row[6]
        @kibera_child.orphan = row[7]
        @kibera_child.name_of_parent_or_guardian = row[8]
        @kibera_child.height_in_cm = row[9]
        # SKIP Row 10 Height in inches
        # SKIP Row 11 Height in feet/inches
        @kibera_child.weight_in_kg = row[12]
        # SKIP Row 13 = Weight in pounds
        @kibera_child.uam_in_cm = row[14]
        # SKIP Row 15 = UAM in inches
        @kibera_child.assessment_temperature_in_fahrenheit = row[16]
        # Row 17 = Blood Pressure
        # @kibera_child.blood_pressure_systolic = row[17]
        # @kibera_child.blood_pressure_diastolic = row[17]
          @kibera_child.has_hearing_complaints = row[18]
          @kibera_child.vision_right = row[19]
          @kibera_child.vision_left = row[20]
          @kibera_child.has_cavities = row[21]
          @kibera_child.has_teeth_missing = row[22]
          @kibera_child.has_healthy_tongue = row[23]
          @kibera_child.has_red_patches = row[24]
          @kibera_child.has_evidence_of_yeast = row[25]
          @kibera_child.has_big_belly = row[26]
          @kibera_child.has_swollen_feet = row[27]
          @kibera_child.has_thin_arms_or_legs = row[28]
          @kibera_child.has_hair_loss = row[29]
          @kibera_child.has_mouth_sores = row[30]
          @kibera_child.has_scalp_fungus = row[31]
          @kibera_child.has_dry_skin = row[32]
          @kibera_child.has_rashes = row[33]
          @kibera_child.rash_location = row[34]
          @kibera_child.has_had_tb = row[35]
          @kibera_child.tb_date = row[36]
          @kibera_child.has_tb_treatment_completed = row[37]
          @kibera_child.has_had_typhoid = row[38]
          @kibera_child.typhoid_date = row[39]
          @kibera_child.has_had_malaria = row[40]
          @kibera_child.malaria_date = row[41]
          @kibera_child.has_menstruated = row[42]
          @kibera_child.has_received_menstrual_products = row[43]
          @kibera_child.menstrual_products_distribution_date = row[44]
          @kibera_child.has_menstrual_product_access = row[45]
          @kibera_child.has_toothbrush = row[46]
          @kibera_child.has_toothpaste = row[47]
          @kibera_child.has_soap = row[48]
          @kibera_child.hygenall_products_distribution_date = row[49]
          @kibera_child.sleeping_location = row[50]
          @kibera_child.sleeps_with_mosquito_net = row[51]
          @kibera_child.has_bible = row[52]
          @kibera_child.is_christian = row[53]
          @kibera_child.is_attending_church = row[54]
          @kibera_child.church_location = row[55]
          @kibera_child.favorite_color = row[56]
          @kibera_child.meals_eaten_per_day = row[57]
          @kibera_child.has_food_available_at_home = row[58]
          @kibera_child.is_food_prepared_with_charcoal = row[59]
          @kibera_child.has_windows_in_home = row[60]
          @kibera_child.has_school_uniform = row[61]
          @kibera_child.is_school_uniform_in_good_condition = row[62]
          @kibera_child.state_of_school_uniform = row[63]
          @kibera_child.dress_size = row[64]
          @kibera_child.shirt_size = row[65]
          @kibera_child.shorts_size = row[66]
          @kibera_child.has_shoes = row[67]
          @kibera_child.is_shoes_in_good_condition = row[68]
          @kibera_child.shoe_size = row[69]
          @kibera_child.additional_comments = row[70]
          
          # Physical Exam information
          @kibera_child.physical_examination_date = row[71]
          @kibera_child.physical_examination_temperature_in_celsius = row[72]
          @kibera_child.health_notes = row[73]
          @kibera_child.observations = row[74]
          @kibera_child.recommendations = row[75]
          @kibera_child.is_antibiotics_needed = row[76]
          @kibera_child.is_antihistamines_needed = row[77]
          @kibera_child.is_antifungals_needed = row[78]
          @kibera_child.is_vitamins_needed = row[79]
          @kibera_child.is_ear_syringing_needed = row[80]
          @kibera_child.is_deworming_needed = row[81]
          @kibera_child.is_stool_sample_needed = row[82]
          @kibera_child.is_dental_attention_needed = row[83]
          @kibera_child.is_opthamologist_needed = row[84]
          
          # @kibera_child.is_pain_killers_needed = row[1]
          #@kibera_child.is_blood_test_needed = row[1]
          #@kibera_child.is_washing_needed = row[1]
          #@kibera_child.has_umbilical_hernia = row[1]
          #@kibera_child.additional_physical_examination_notes = row[1]
         
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
