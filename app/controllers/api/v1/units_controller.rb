class Api::V1::UnitsController < ApiController
  	def index
    	unsorted_units = Unit.all
        units = unsorted_units.sort {
            |x, y| x.name.sub(/^(the|a|an)\s/i, "").downcase <=>
            y.name.sub(/^(the|a|an)\s/i, "").downcase
        }
    	render json: units
  	end

  	def show
  		render json: Unit.find(params[:id])
  	end

  	def create
  		unit = Unit.new({
  			name: params[:name],
  			unit_size: params[:unit_size],
  			unit_strength: params[:unit_strength],
  			speed: params[:speed],
  			melee: params[:melee],
  			ranged: params[:ranged],
  			defense: params[:defense],
  			attacks: params[:attacks],
  			points: params[:points],
  			special: params[:special],
            army_id: params[:army_id],
            army_name: Army.find_by_id(params[:army_id]).name
  		})
  		if unit.save
  			render json: unit
  		else
  			render json: { error: unit.errors.full_messages.join(' * ') }
  		end
  	end

  	def update
  		unit = Unit.find(params[:id])
  		if unit.update({
  			name: params[:name],
  			unit_size: params[:unit_size],
  			unit_strength: params[:unit_strength],
  			speed: params[:speed],
  			melee: params[:melee],
  			ranged: params[:ranged],
  			defense: params[:defense],
  			attacks: params[:attacks],
  			points: params[:points],
  			special: params[:special],
            army_id: unit.army_id,
            army_name: Army.find_by_id(unit.army_id).name
  		})
  			render json: { unit: unit }
  		else
  			render json: { error: unit.errors.full_messages.join(' * ') }
  		end
  	end

  	def destroy
  		unit = Unit.find(params[:id])
  		unit.destroy
  		render json: { unit: unit }
  	end

  	private

  	def unit_params
  		params.require(:unit).permit(:name)
  	end
end