class SiteController < ApplicationController
  include SiteHelper
  require 'email_provider'

  before_action :setup_email_provider, only: [:subscribe_email, :unsubscribe_email]

  def subscribe_email

    email = params[:email]
    if !email.blank?
      res = @mp.subscribe_user(email)

      if res[:result]
        flash[:notice] = res[:message]
        redirect_to root_path
      else
        flash[:alert] = res[:message]
        render 'subscribe'
      end
    else
      render 'subscribe'
    end
  end

  def subscribe

  end

  def home

  end

  def guide

  end

  def about

  end

  def faq

  end

  def published

  end

  def photography
    @covers = fill_cover_photos('photography')

    @first_keys = @covers.keys.slice(0, 2)
    @mid_keys = @covers.keys.slice(2, 2)
    @last_keys = @covers.keys.slice(4, 2)
  end

  def photography_detail
    unless params[:series_name].nil?
      unless params[:series_name].blank?
        @covers = fill_photos('photography/' + params[:series_name])
        @series = params[:series_name]

        logger.debug 'photography/' + params[:series_name]

        per_col = (@covers.length / 3.0).floor

        logger.debug per_col

        @first_keys = @covers.keys.slice(0, per_col)
        @mid_keys = @covers.keys.slice(per_col, per_col)
        @last_keys = @covers.keys.slice(2 * per_col, per_col + 1)

        render 'photography_series'
      end
    end
  end

  def painting
    @paintings = fill_images('paintings')

    logger.debug @paintings

    @first_keys = @paintings.keys.slice(0, 3)
    @mid_keys = @paintings.keys.slice(3, 4)
    @last_keys = @paintings.keys.slice(6, 3)
  end

  def painting_detail
    unless params[:name].nil?
      unless params[:name].blank?
        @is_photo = false
        @work = Hash.new
        paintings = fill_images('paintings')

        @work[:title] = params[:name]
        #logger.debug @work[:title]

        unless @work[:title].nil?
          @work[:file_name] = paintings[params[:name]]

          logger.debug @work[:file_name] # Is blank!!  paintings[:name] is not working right
        end
      end
    end
  end

  def shortstories
    @content = fill_stories('shortstories')

    logger.debug @content

    @first_keys = @content.keys.slice(0, 3)
    @mid_keys = @content.keys.slice(3, 2)
    @last_keys = @content.keys.slice(5, 3)
  end

  def photo
    unless params[:name].nil?
      unless params[:name].blank?
        @is_photo = true
        @work = Hash.new
        paintings = fill_photos('photography/' + params[:series_name])

        @work[:title] = params[:name]

        unless @work[:title].nil?
          @work[:file_name] = paintings[params[:name]]

          render 'painting_detail'
        end
      end
    end
  end

  def short_detail
    unless params[:name].nil?
      unless params[:name].blank?
        @work = Work.new
        @is_poem = false
        content = fill_stories('shortstories')

        @work.title = params[:name]

        unless @work.title.nil?
          @work.body = content[params[:name]]
          @work.author_name = 'Fuinneamh'

          render 'works/show'
        end
      end
    end
  end

  def poetry_detail
    unless params[:name].nil?
      unless params[:name].blank?
        @work = Work.new
        @is_poem = true

        content = fill_stories('poetry')

        @work.title = params[:name]

        unless @work.title.nil?
          @work.body = content[params[:name]]
          @work.author_name = 'Fuinneamh'

          logger.debug params[:name]
          logger.debug content[params[:name]]

          render 'works/show'
        end
      end
    end
  end

  def poetry
    @content = fill_stories('poetry/summaries')

    logger.debug @content

    @first_keys = @content.keys.slice(0, 2)
    @mid_keys = @content.keys.slice(2, 1)
    @last_keys = @content.keys.slice(3, 2)
  end

  def parastories
    unless params[:name].nil?
      unless params[:name].blank?
        if params[:name] == 'pocket'
          @content = fill_stories('paragraphs/pocket')

          @first_keys = @content.keys.slice(0, 2)
          @mid_keys = @content.keys.slice(2, 1)
          @last_keys = @content.keys.slice(3, 2)

          render "site/pocket"
        end
        if params[:name] == 'card'
          @content = fill_stories('paragraphs/card')

          @first_keys = @content.keys.slice(0, 2)
          @mid_keys = @content.keys.slice(2, 1)
          @last_keys = @content.keys.slice(3, 2)

          render "site/card"
        end
      end
    end
  end

  def thankyou

  end

  def stats
    @donated = Donation.all.sum(:amount).to_s;
    @total_works = Work.count(:id)
    @total_words = Work.sum(:word_count)
  end

  protected
    def setup_email_provider
      @mp = EmailProvider.new
    end
end
