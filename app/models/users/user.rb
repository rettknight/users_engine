module Users
  # == Active
  #
  # 0 = Cuenta desactivada
  # 1 = Cuenta activada
  #
  # == Schema Information
  #
  # Table name: users
  #
  #  id                   :integer          not null, primary key
  #  active               :integer          default(1), not null
  #  name                 :string(100)      not null
  #  lastname             :string(100)
  #  email                :string(100)      not null
  #  city_id              :integer
  #  department_id        :integer
  #  encrypted_password   :string(255)
  #  salt                 :string(200)
  #  updatedAt            :datetime
  #  createdAt            :datetime
  #  deletedAt            :datetime
  #  lastConnection       :datetime
  #  rfc                  :string(255)
  #  curp                 :string(255)
  #  avatar               :string(255)
  #  userType_id          :integer
  #  time_requested       :datetime
  #  password_reset_token :string(255)
  #  imei                 :string(255)
  #
  class User < ActiveRecord::Base
    attr_accessor :password
    belongs_to :usertype

    has_many :relationships, :dependent => :destroy,
             :foreign_key => 'owner_id'
    has_many :contacts, :through => :relationships,
             :source => :owner
    has_one :picture

    email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :name, :presence => true,
              :length   => {:maximum => 50}
    validates :email, :presence => true,
              :format   => {:with => email_regex},
              :uniqueness => {:case_sensitive => false}
    validates :password, :presence => true,
              :confirmation => true,
              :length => {:within => 6..30},
              :on => :create
    validates :active, :presence => true
    validates :userType_id, :presence => true
    before_save :encrypt_password, :set_timestamps, :set_userType
    ##
    #Genera token y lo asigna cambiando el tiempo,
    #de esta manera se controla que el token no sirva después
    #de un tiempo
    def send_password_reset
      generate_token(:password_reset_token)
      self.time_requested = Time.zone.now
      save(validate: false)
      UserSupport.password_reset(self).deliver_now
    end
    ##
    #Metodo para generar el token que será generado con una encriptación
    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
    ##
    #Regresa verdadero si el UserType es igual a 2 (Admin)
    def admin?
      userType_id == 2
    end
    ##
    #Metodo de validación para checar que la contraseña insertada
    #sea igual a la contraseña del usuario.
    def has_password?(submitted_password)
      encrypted_password == encrypt(submitted_password)
    end
    ##
    #Metodo que pone las timestamps iniciales en una cuenta de usuario.
    def set_timestamps
      if self.updatedAt.nil?
        self.updatedAt= Time.now
        self.createdAt = Time.now
      end
      self.lastConnection = Time.now
    end
    ##
    #Metodo para agregar un contacto
    def create_contact(contact)
      relationships.create!(:contact_id => contact.id)
    end
    ##
    #Metodo para remover un contacto
    def remove_contact(contact)
      relationships.find_by_contact_id(contact).destroy
    end
    ##
    #Metodo para ver si un usuario es contacto del usuario
    def contact?(contact)
      relationships.find_by_contact_id(contact)
    end
    ##
    #Asigna userType = 1 (Miembro) si no existe un usertype
    def set_userType
      self.userType_id = 1 unless !userType_id.nil?
    end
    class << self
      ##
      #Autenticación
      def authenticate(email, submitted_password)
        user = find_by_email(email)
        (user && user.has_password?(submitted_password)) ? user : nil
      end
      ##Otro metodo para la autenticación
      def authenticate_with_salt(id, cookie_salt)
        user = find_by_id(id)
        (user && user.salt == cookie_salt) ? user : nil
      end
      ##
      #Busqueda de usuarios
      def search(query)
        where("name like ?", "#{query}%")
      end
    end
    private
    ##
    #Encriptación
    def encrypt_password
      if !password.blank?
        self.salt = make_salt if new_record?
        self.encrypted_password = encrypt(password)
      end
    end
    ##
    #Crea un hash para el usuario
    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    ##Hash utilizado para encrypt
    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
    ##Crea salt para el usuario
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end
  end
end
