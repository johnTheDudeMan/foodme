# To do: if editing email address, confirm with activation before saving
# To do: figure out how to cleare carrierwave cache

class User < ActiveRecord::Base
  attr_accessor :remember_token, :activation_token, :pw_reset_token
  has_one :kitchen, dependent: :destroy
  before_save :downcase_email
  before_create :create_activation_token
  after_create :create_kitchen
  mount_uploader :avatar, AvatarUploader
  validates :name, presence: true, length: { maximum: 40 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  validates :blurb, length: {maximum: 280}
  validates :avatar, file_size: { less_than: 4.megabytes }

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    # change @ to self when you figure out what the differnece is if any.
    @remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(@remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def create_password_reset_digest
    @pw_reset_token = User.new_token
    update_columns(pw_reset_digest: User.digest(@pw_reset_token), pw_reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    pw_reset_sent_at < 2.hours.ago
  end


  private

    def downcase_email
      self.email = email.downcase
    end

    def create_activation_token
      @activation_token = User.new_token
      self.activation_digest = User.digest(@activation_token)
    end

end
