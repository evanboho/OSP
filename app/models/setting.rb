class Setting < ActiveRecord::Base
  attr_accessible :page, :settings_hash, :link, :tagline

  serialize :settings_hash, Hash

  scope :resources, where(:page => "resources")
  scope :contact_us, where(:page => "contact_us")

  def link
    self.settings_hash[:link]
  end

  def link=(value)
    self.settings_hash[:link] = value.to_s
  end

  def tagline
    self.settings_hash[:tagline]
  end

  def tagline=(value)
    self.settings_hash[:tagline] = value.to_s
  end


end
