module Contexts
    module ShiftJobContexts
        
        def create_shift_jobs
            @ed_assignment = FactoryBot.create(:shift, assignment: @assign_ed, date: 17.day.from_now.to_date)
            @ed_shift = FactoryBot.create(:shift, assignment: @assign_ed, date: 18.day.from_now.to_date)
            @ed_shift_job1 = FactoryBot.create(:shift_job, shift: @ed_shift, job: @sweeping)
            @ed_shift_job2 = FactoryBot.create(:shift_job, shift: @ed_shift, job: @cleaning_windows)
            @ed_shift_job2 = FactoryBot.create(:shift_job, shift: @ed_shift, job: @dusting)
            @ed_shift_job3 = FactoryBot.create(:shift_job, shift: @ed_shift, job: @manage)
        end
        
        def destroy_shift_jobs
            @ed_assignment.destroy
            @ed_shift.destroy
            @ed_shift_job1.destroy
            @ed_shift_job2.destroy
            @ed_shift_job2.destroy
            @ed_shift_job3.destroy
        end
        
        def create_additional_shift_jobs
            @ben_assignment = FactoryBot.create(:shift, assignment: @assign_ben, date: 2.day.from_now.to_date)
            @ben_shift = FactoryBot.create(:shift, assignment: @assign_ben, date: 3.day.from_now.to_date)
            @ben_shift_job1 = FactoryBot.create(:shift_job, shift: @ben_shift, job: @sweeping)
            @ben_shift_job2 = FactoryBot.create(:shift_job, shift: @ben_shift, job: @cleaning_windows)
            @ben_shift_job2 = FactoryBot.create(:shift_job, shift: @ben_shift, job: @dusting)
            @ben_shift_job3 = FactoryBot.create(:shift_job, shift: @ben_shift, job: @manage)
        end
        
        def destroy_additional_shift_jobs
            @ben_assignment.destroy
            @ben_shift.destroy
            @ben_shift_job1.destroy
            @ben_shift_job2.destroy
            @ben_shift_job2.destroy
            @ben_shift_job3.destroy
        end
        
    end
end