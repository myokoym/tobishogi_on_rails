class GameController < ApplicationController
  def index
    @state ||= "222000111"
    @usage = "Usage: http://#{request.host}/game/move?state=222000111"
  end

  def move
    state = params[:state]
    unless state
      @state = "入力を間違えてるわ"
      render_index
      return
    end
    @state = think(state)
    render_index
  end

  private
  def render_index
    render :action => :index
  end

  def think(state)
    status = state.split(//)
    catch(:done) {
      0.upto(2) do |i|
        if status[i] == "2"
          if status[i + 3] == "1"
            status[i], status[i + 6] = status[i + 6], status[i]
            throw :done
          end
        end
      end
      0.upto(5) do |i|
        if status[i] == "2"
          if status[i + 3] == "0"
            status[i], status[i + 3] = status[i + 3], status[i]
            throw :done
          end
        end
      end
    }
    return status.join
  end
end

