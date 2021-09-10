# frozen_string_literal: true

module Api
  module V1
    # Army conteroller
    class ArmiesController < ApplicationController
      before_action :sanitize_page_params

      def index
        @armies = Army.where(battle_id: params[:battle_id])
        render json: @armies
      end

      def show
        armies = Army.where(battle_id: params[:battle_id]).find(id: params[:id])
        render json: armies
      end

      def create
        army = Army.new(army_params)

        if army.save
          render json: army
        else
          render json: { error: army.errors, message: 'Unable to create new army' }, status: 400
        end
      end

      def update
        army = Army.find(params[:id])

        if army.update_attributes(army_params)
          render json: army
        else
          render josn: { error: army.errors, message: 'Unable to update army' }, status: 400
        end
      end

      private

      def sanitize_page_params
        params[:units] = params[:units].to_i
        params[:attack_strategy] = params[:attack_strategy].to_i
      end

      def army_params
        params.permit(:name, :units, :attack_strategy, :battle_id)
      end
    end
  end
end
