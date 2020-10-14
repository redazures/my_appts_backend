require 'pry'

class ProjectsController < ApplicationController

    def index
        projects = Project.all
        render json: projects

    end

    def show
        project = Project.find_by(id: params[:id])
        render json: project
    end

    def create
        project = Project.new(project_params)

        if project.save 
            render json: project
        else 
            render json: { error: project.errors.messages }, status: 422
        end

    end

    def update 
        project = Project.find_by(id: params[:id])
        if project.update(project_params)
            render json: project
        else
            render json: { error: project.errors.messages }, status: 422
        end
        
    end

    def destroy
        # binding.pry
        project = Project.find(params[:id])
        if project

            project.destroy
            head :no_content
        else 
            render json: { error: project.errors.messages }, status: 422
        end

    end

    private

    def project_params
        params.require(:project).permit(:user_id, :client_id, :name, :description, :amount, :paid, :start, :end, :status)
    end

end
