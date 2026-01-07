package com.sdr.entity;

import java.time.LocalDate;
import java.time.LocalDateTime;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;

    @NotBlank
    @Size(min = 3, max = 50)
    @Pattern(regexp = "^[A-Za-z ]+$")
    private String name;

    @NotBlank
    @Email
    @Column(unique = true, nullable = false)
    private String email;

    @NotBlank
    @Size(min = 6)
    private String password;

    @NotBlank
    @Pattern(regexp = "^[6-9]\\d{9}$")
    @Column(length = 10, nullable = false)
    private String phone;
    
    @NotNull
    @Column(name = "dob")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dob;

  

	@NotBlank
    private String gender;

    @NotBlank
    @Pattern(regexp = "^[A-Za-z ]{2,}$")
    private String state;

    @Column(name = "created_at", nullable = false, updatable = false)
    private LocalDate createdAt;
    
    @Column(name = "email_verified")
    private boolean emailVerified = false;

    @Column(name = "email_otp")
    private String emailOtp;

    @Column(name = "email_otp_expiry")
    private LocalDateTime emailOtpExpiry;
    

    public boolean isEmailVerified() {
		return emailVerified;
	}

	public void setEmailVerified(boolean emailVerified) {
		this.emailVerified = emailVerified;
	}

	public String getEmailOtp() {
		return emailOtp;
	}

	public void setEmailOtp(String emailOtp) {
		this.emailOtp = emailOtp;
	}

	public LocalDateTime getEmailOtpExpiry() {
		return emailOtpExpiry;
	}

	public void setEmailOtpExpiry(LocalDateTime emailOtpExpiry) {
		this.emailOtpExpiry = emailOtpExpiry;
	}

	@PrePersist
    protected void onCreate() {
        this.createdAt = LocalDate.now();
    }
    
    @Column(name = "profile_photo")
    private String profilePhoto;

    //otp all things
    
    @Column(name = "reset_otp")
    private String resetOtp;

    @Column(name = "otp_expiry")
    private LocalDateTime otpExpiry;


    public String getResetOtp() {
		return resetOtp;
	}

	public void setResetOtp(String resetOtp) {
		this.resetOtp = resetOtp;
	}

	public LocalDateTime getOtpExpiry() {
		return otpExpiry;
	}

	public void setOtpExpiry(LocalDateTime otpExpiry) {
		this.otpExpiry = otpExpiry;
	}


	public User() {}

    // Constructor (optional)
    public User(int id, String name, String email, String password,
                String phone, String gender,
                String state, LocalDate createdAt) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.password = password;
        this.phone = phone;
        this.gender = gender;
        this.state = state;
        this.createdAt = createdAt;
    }

    // Getters & Setters

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }


    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public LocalDate getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDate createdAt) {
        this.createdAt = createdAt;
    }
    
    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
    
    public LocalDate getDob() {
  		return dob;
  	}

  	public void setDob(LocalDate dob) {
  		this.dob = dob;
  	}

}
