class GameController < ApplicationController
  def index
    @state ||= "222000111"
    render_graphic
  end

  def move
    state = params[:state]
    unless state
      redirect_to :action => :index
      return
    end
    status = state.split(//)
    place = params[:place]
    status = moving(status, place.to_i, "1")
    @winner = winner(status)
    if @winner == "1"
      @state = status.join
      render_index 
      return
    end
    status = think(status)
    @winner = winner(status)
    @state = status.join
    render_index
  end

  def graphic
    state = params[:state]
    unless state
      redirect_to :action => :index
      return
    end
    status = state.split(//)
    place = params[:place]
    status = moving(status, place.to_i, "1")
    @winner = winner(status)
    if @winner == "1"
      @state = status.join
      render_graphic 
      return
    end
    status = think(status)
    @winner = winner(status)
    @state = status.join
    render_graphic
  end

  private
  def render_index
    @title ||= "飛び将棋"
    render :action => :index
  end

  def render_graphic
    @title ||= "飛び将棋-Graphic"
    render :action => :graphic
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
    status
  end

  def think(status)
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
    return status
  end

  def winner(status)
    return "1" if status[0..2].all? {|v| v == "1" }
    return "2" if status[-3..-1].all? {|v| v == "2" }
    nil
  end
end

