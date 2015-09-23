class User < ActiveRecord::Base
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false },
                    allow_nil: true
  has_attached_file :avatar,
                    :storage => :s3,
                    :bucket => 'insurance-pricing-room',
                    :s3_credentials => {bucket: 'insurance-pricing-room',
                                        access_key_id: 'AKIAJLIQ5LEKAAF3CR2Q',
                                        secret_access_key: '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'},
                    :s3_protocol    => "https",
                    :s3_host_name   => "s3-eu-west-1.amazonaws.com"
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end
end
