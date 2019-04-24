module Contexts
    module ShiftContexts
        
        def create_shifts
            @morning = FactoryBot.create(:shift, assignment_id: @assign_ed.id, date: "2019-04-17", start_time: "05:39:00", end_time: "20:39:02", notes: "Morning Shift")
            @noon = FactoryBot.create(:shift, assignment_id: @assign_ben.id, date: "2019-04-19", start_time: "18:39:00", end_time: "20:39:02", notes: "Noon Shift")
            @night = FactoryBot.create(:shift, assignment_id: @promote_ben.id, date: "2019-04-19", start_time: "19:39:00", end_time: "20:39:02", notes: "Night Shift")
        end
        
        def destroy_shifts
            @morning.destroy
            @noon.destroy
            @night.destroy
        end
        
        def create_additional_shifts
            @afternoon = FactoryBot.create(:shift, assignment_id: @assign_cindy.id, date: "2019-02-10", start_time: "06:39:3", end_time: "04:39:02", notes: "Afternoon Shift")
            @nineamshift = FactoryBot.create(:shift, assignment_id: @assign_kathryn.id, date: "2019-03-19", start_time: "10:39:30", end_time: "20:39:02", notes: "9 AM Shift")
            @twelvepmshift = FactoryBot.create(:shift, assignment_id: @assign_ed.id, date: "2019-01-19", start_time: "14:39:00", end_time: "20:39:02", notes: "12 PM Shift")
        end
        
        def destroy_additional_shifts
            @afternoon.destroy
            @nineamshift.destroy
            @twelvepmshift.destroy
        end       
        
    end 
end