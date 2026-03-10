class Api::V1::JobsController < ApplicationController
    
    def index
        jobs = Job.all 
        render json: jobs
    end
    def show
        @job = Job.find(params[:id])
        render json: @job
    end
    def update
        @job = Job.find(params[:id])
        if @job.update(job_params)
            render json: @job
        else
            render json: {errors: @job.errors.full_messages}, status: :unprocessable_entity
        end
    end
    def scrape
        JobScraper.new.call
        render json: { message: 'Scrape completed successfully' }
    end
    private
    def job_params
        params.require(:job).permit(:visa_friendly)
    end
end
