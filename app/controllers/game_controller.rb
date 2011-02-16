class GameController < ApplicationController
  def index
    @state ||= "222000111"
    render_index
  end

  def move
    status = params[:state].split(//)
    place = params[:place]
    status = moving(status, place.to_i, "1")
    @state = think(status.join)
    render_index
  end

  private
  def render_index
    @title ||= "飛び将棋"
    render :action => :index
  end

  def moving(status, i, turn)
    if turn == "1"
      if status[i - 3] == "2"
        status[i], status[i - 6] = status[i - 6], status[i]
      elsif status[i - 3] == "0"
        status[i], status[i - 3] = status[i - 3], status[i]
      end
    else
      if status[i + 3] == "1"
        status[i], status[i + 6] = status[i + 6], status[i]
      elsif status[i + 3] == "0"
        status[i], status[i + 3] = status[i + 3], status[i]
      end
    end
    p status
    status
  end

  def think(state)
    status = state.split(//)
    catch(:done) {
      0.upto(2) do |i|
        if status[i] == "2"
          if status[i + 3] == "1"
            moving(status, i, "2")
            throw :done
          end
        end
      end
      0.upto(5) do |i|
        if status[i] == "2"
          if status[i + 3] == "0"
            moving(status, i, "2")
            throw :done
          end
        end
      end
    }
    return status.join
  end
end

