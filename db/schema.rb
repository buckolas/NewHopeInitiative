# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120527212105) do

  create_table "child_photos", :force => true do |t|
    t.string   "image"
    t.integer  "kibera_child_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "child_photos", ["kibera_child_id"], :name => "index_child_photos_on_kibera_child_id"

  create_table "kibera_children", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "grade"
    t.date     "assessment_documentation_date"
    t.date     "birth_date"
    t.string   "gender"
    t.string   "orphan"
    t.string   "name_of_parent_or_guardian"
    t.float    "height_in_cm"
    t.float    "weight_in_kg"
    t.float    "uam_in_cm"
    t.float    "assessment_temperature_in_fahrenheit"
    t.integer  "blood_pressure_systolic"
    t.integer  "blood_pressure_diastolic"
    t.boolean  "has_hearing_complaints"
    t.integer  "vision_right"
    t.integer  "vision_left"
    t.boolean  "has_cavities"
    t.boolean  "has_teeth_missing"
    t.boolean  "has_healthy_tongue"
    t.boolean  "has_red_patches"
    t.boolean  "has_evidence_of_yeast"
    t.boolean  "has_big_belly"
    t.boolean  "has_swollen_feet"
    t.boolean  "has_thin_arms_or_legs"
    t.boolean  "has_hair_loss"
    t.boolean  "has_mouth_sores"
    t.boolean  "has_scalp_fungus"
    t.boolean  "has_dry_skin"
    t.boolean  "has_rashes"
    t.string   "rash_location"
    t.boolean  "has_had_tb"
    t.date     "tb_date"
    t.boolean  "has_tb_treatment_completed"
    t.boolean  "has_had_typhoid"
    t.date     "typhoid_date"
    t.boolean  "has_had_malaria"
    t.date     "malaria_date"
    t.boolean  "has_menstruated"
    t.boolean  "has_received_menstrual_products"
    t.date     "menstrual_products_distribution_date"
    t.boolean  "has_menstrual_product_access"
    t.boolean  "has_toothbrush"
    t.boolean  "has_toothpaste"
    t.boolean  "has_soap"
    t.date     "hygenall_products_distribution_date"
    t.string   "sleeping_location"
    t.boolean  "sleeps_with_mosquito_net"
    t.boolean  "has_bible"
    t.boolean  "is_christian"
    t.boolean  "is_attending_church"
    t.string   "church_location"
    t.string   "favorite_color"
    t.integer  "meals_eaten_per_day"
    t.boolean  "has_food_available_at_home"
    t.boolean  "is_food_prepared_with_charcoal"
    t.boolean  "has_windows_in_home"
    t.boolean  "has_school_uniform"
    t.boolean  "is_school_uniform_in_good_condition"
    t.string   "state_of_school_uniform"
    t.string   "dress_size"
    t.string   "shirt_size"
    t.string   "shorts_size"
    t.boolean  "has_shoes"
    t.boolean  "is_shoes_in_good_condition"
    t.float    "shoe_size"
    t.text     "additional_comments"
    t.date     "physical_examination_date"
    t.float    "physical_examination_temperature_in_celsius"
    t.text     "health_notes"
    t.text     "observations"
    t.text     "recommendations"
    t.boolean  "is_antibiotics_needed"
    t.boolean  "is_antihistamines_needed"
    t.boolean  "is_antifungals_needed"
    t.boolean  "is_vitamins_needed"
    t.boolean  "is_ear_syringing_needed"
    t.boolean  "is_deworming_needed"
    t.boolean  "is_stool_sample_needed"
    t.boolean  "is_dental_attention_needed"
    t.boolean  "is_opthamologist_needed"
    t.boolean  "is_pain_killers_needed"
    t.boolean  "is_blood_test_needed"
    t.boolean  "is_washing_needed"
    t.boolean  "has_umbilical_hernia"
    t.text     "additional_physical_examination_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "password"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.boolean  "is_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "login_count",        :default => 0, :null => false
    t.integer  "failed_login_count", :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
  end

end
