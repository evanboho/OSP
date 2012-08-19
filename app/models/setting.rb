class Setting < ActiveRecord::Base
  attr_accessible :page, :settings_hash, :link, :tagline, :name, :notifier_email

  serialize :settings_hash, Hash

  scope :resources, where(:page => "resources")
  scope :settings, where(:page => "settings")
  scope :contact_us, where(:page => "contact_us")

  def notifier_email
    self.settings_hash[:email]
  end

  def notifier_email=(value)
    self.settings_hash[:email] = value.to_s
    self.page = "contact_us"
  end

  def name
    self.settings_hash[:name]
  end

  def name=(value)
    self.settings_hash[:name] = value.to_s
    self.page = "resources"
  end

  def link
    self.settings_hash[:link]
  end

  def link=(value)
    self.settings_hash[:link] = value.to_s
    self.page = "resources"
  end

  def tagline
    self.settings_hash[:tagline]
  end

  def tagline=(value)
    self.settings_hash[:tagline] = value.to_s
    self.page = "resources"
  end


end
