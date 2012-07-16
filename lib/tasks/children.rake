namespace :children do
   desc "Ensures that a child's class string value is valid"
   task :update_grades => :environment do
      index = 0
      KiberaChild.all.each{|child|
         if child.update_attributes(:grade => String.to_grade(child.grade))
            index += 1
         end
      }
      puts "Successfully updated #{index} children out of #{KiberaChild.count}"
   end
   
   desc "Ensures that a child's orphan string value is valid"
    task :update_orphan => :environment do
       index = 0
       KiberaChild.all.each{|child|
          if child.update_attributes(:orphan => String.to_orphan(child.orphan))
             index += 1
          end
       }
       puts "Successfully updated #{index} children out of #{KiberaChild.count}"
    end
    
end