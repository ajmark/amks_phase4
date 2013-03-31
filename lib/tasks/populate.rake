namespace :db do
  desc "Erase and fill database"
  # creating a rake task within db namespace called 'populate'
  # executing 'rake db:populate' will cause this script to run
  task :populate => :environment do
    # Invoke rake db:migrate just in case...
    Rake::Task['db:migrate'].invoke
    
    # Need gem to make this work: faker [http://faker.rubyforge.org/rdoc/]
    require 'faker'
    
    # Step 0: clear any old data in the db
    [Event, Student, Section, Registration].each(&:delete_all)
  
    # Step 1: add some events
    events = %w[Sparring Forms Breaking]
    events.each do |ename|
      event = Event.new
      event.name = ename
      event.active = true
      event.save!
    end
    event_ids = Event.all.map(&:id)  # could also write as = Event.pluck(:id)
    sparring_id = Event.find_by_name('Sparring').id
    forms_id = Event.find_by_name('Forms').id
    breaking_id = Event.find_by_name('Breaking').id
    
    # Step 3: add some students, sections, and registrations
    age_ranges = [[5,6],[7,8],[9,10],[11,12],[13,15],[16,18],[19,24],[25,34],[35,nil]]
    rank_ranges = [[1,2],[3,4],[5,7],[8,9],[10,10],[11,nil]]
    rank_ranges.each do |r_range|
      age_ranges.each do |a_range|
        # Step 3a: add some students that are in this age and rank range
        eligible_students_ids = Array.new
        n = (4..12).to_a.sample
        n.times do
          if a_range[1].nil?
            months_old = ((a_range[0]*12+1)..(a_range[0]*12+10)).to_a.sample
          else
            months_old = ((a_range[0]*12+1)..(a_range[1]*12+10)).to_a.sample
          end
          stu = Student.new
          stu.first_name = Faker::Name.first_name
          stu.last_name = Faker::Name.last_name
          stu.date_of_birth = months_old.months.ago.to_date
          if r_range[1].nil?
            stu.rank = r_range[0]
          else
            stu.rank = (r_range[0]..r_range[1]).to_a.sample
          end
          stu.phone = rand(10 ** 10).to_s.rjust(10,'0')
          stu.waiver_signed = true
          stu.active = true
          stu.save!
          eligible_students_ids << stu.id
        end
        
        # Step 3b: add a section for each event for this age/rank range
        sections_for_group = Array.new
        event_ids.each do |e_id|
          section = Section.new
          section.event_id = e_id
          section.min_age = a_range[0]
          section.max_age = a_range[1]
          section.min_rank = r_range[0]
          section.max_rank = r_range[1]
          section.active = true
          section.save!
          sections_for_group << section
        end
        
        # Step 3c: register some, most or all students for the sections just created
        eligible_students_ids.each do |e_stu_id|
          # almost everyone is in forms event
          unless rand(9).zero?
            forms_reg = Registration.new
            forms_reg.student_id = e_stu_id
            forms_reg.section_id = sections_for_group.select{|s| s.event_id == forms_id}.first.id
            forms_reg.date = (2..16).to_a.sample.days.ago.to_date
            forms_reg.save!
          end
          
          # majority are in sparring (none in old black-belt sparring)
          unless rand(3).zero? || (a_range[0]==35 && r_range[0]==11)
            sparring_reg = Registration.new
            sparring_reg.student_id = e_stu_id
            sparring_reg.section_id = sections_for_group.select{|s| s.event_id == sparring_id}.first.id
            sparring_reg.date = (2..16).to_a.sample.days.ago.to_date
            sparring_reg.save!          
          end
          
          # minority in breaking (none in two junior sections)
          unless rand(5) > 2 || (a_range[0]==5 && r_range[0]==1) || (a_range[0]==9 && r_range[0]==3)
            breaking_reg = Registration.new
            breaking_reg.student_id = e_stu_id
            breaking_reg.section_id = sections_for_group.select{|s| s.event_id == breaking_id}.first.id
            breaking_reg.date = (2..16).to_a.sample.days.ago.to_date
            breaking_reg.save!          
          end
        end     
      end
    end
  end
end