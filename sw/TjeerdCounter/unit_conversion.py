# this class can be used as a conversion calculator between different unit
# systems. Currently inlcuded are SI and cgs.
#
# Constants are defined as much as possible in SI constants
# Functions use constants for their conversions
#
# for convenience all constants are abreviated and the abreviations refer to the
# SI values
#
# changelog:
# Jonas: 2010.06.14 Implement some more convert functions based on the Einstein coeff.....and all that paper
#
import scipy

float=scipy.longfloat


#XXX: this whole thing should become a class that can be used more handy

#########################################
# Generic functions and program constants
abreviated_values_are="_SI"
def abreviated_value(valuename):
	"""This function returns the abreviated value from a given standard set"""
	#XXX: this should be implemented for more generality
	pass

####################
# Physical Constants

#Speed of light
c_SI=float(2.99792458e8)	#in m/s
c_cgs=c_SI*1e2		#in cm/s
c=c_SI

#Plancks constant
h_SI=float(6.62606896e-34)	#in J.s
h_cgs=h_SI*1e7		#in g.cm^2.A^-1.s^-1
h=h_SI

#Diracs constant
hbar_SI=float(h_SI/(2*scipy.pi))	#in J.s
hbar_cgs=h_cgs/(2*scipy.pi)	#in g.cm^2.A^-1.s^-1 
hbar=hbar_SI

#Magnetic constant
mu_nul_SI=float(4*scipy.pi*1e-7)	#in H.m^-1
mu_nul_cgs=mu_nul_SI*1e5	#in g.cm.s^-1.A^-3
mu_nul=mu_nul_SI

#Dielectric constant
eps_nul_SI=1/(mu_nul_SI*c_SI**2) #in F.m^-1
eps_nul_cgs=eps_nul_SI*1e-9
eps_nul=eps_nul_SI

#Elementary charge
e_SI=float(1.602176487e-19)	#in C
e_cgs=e_SI*c_cgs*1e-1	#in esu, statCoulomb
e=e_SI

#Mass of Electron
m_e_SI=float(9.10938215e-31)	#in kg
m_e_cgs=m_e_SI*1e3		#in g
m_e=m_e_SI

#Bohr magneton
mu_B_SI=float(927.400915e-26)	#in J.T^-1
mu_B=mu_B_SI

#Bohr radius
a0_SI=float(5.2917720859e-11)	#in m
a0_cgs=a0_SI*1e2		#in cm
a0=a0_SI

#Rydberg constant
R_SI=float(10973731.568527)	#in m^-1
R=R_SI

#Unified Atomic Mass Unit
u_SI=float(1.660538782e-27)    #in kg
u=u_SI #bla

#Absolute zero temperature
T_zero_C_SI=float(-273.15)  # 0 Kelvin equals -273.15 deg. Celcius
T_zero_C=T_zero_C_SI

#####################
#Conversion Functions

#Frequency
def omega_f(omega):
	"""convert frequency in rad/sec to Hz"""
	return float(omega)/(2.0*scipy.pi)

def f_omega(f):
	"""convert frequency in Hz to rad/sec"""
	return float(f)*2.0*scipy.pi

def lambda_f(wavelength):
    """Convert a wavelength in m to a frequency in Hz"""
    return c_SI/float(wavelength)

def f_lambda(f):
    """Convert a frequency in Hz to a wavelength in m"""
    return c_SI/float(f)

def wavenumber_f(wavenumber):
    """Convert a wavenumber in cm-1 to a frequency in Hz"""
    return float(wavenumber)*100.0*c_SI
    
def f_wavenumber(f):
    """Convert a frequency in Hz to a wavenumber in cm-1"""
    return float(f)/(c_SI*100.0)

def lambda_dlambda_df(wavelength, delta_wavelength):
    """
    Convert a center wavelength and a spectral width (e.g. FWHM of a resonance)
    to a width of the resonance in Hz.
    """
    lower_wavelength=wavelength - delta_wavelength/2.0
    upper_wavelength=wavelength + delta_wavelength/2.0
    return lambda_f(upper_wavelength) - lambda_f(lower_wavelength)

#Pulse properties
def lambda_dlambda_pulse_t(wavelength, delta_wavelength, time_bandwidth_product=0.44):
    """Convert a center wavelength and a spectral width to a pulse duration
       asuming a transform limited pulse with a certain time bandwidht product.
       
       wavelength: central wavelength of the spectrum in (m)
       delta_wavelength: spectral width (FWHM) of the spectrum in (m)
       time_bandwidth_product: can take other values, see below
       
       The default time bandwidth product is for a Gaussian pulse (0.44).
       Other time bandwith products are:
       - Sech^2 shaped pulse: 0.315
    """
    lower_wavelength=wavelength - delta_wavelength/2.0
    upper_wavelength=wavelength + delta_wavelength/2.0
    return lambda_pulse_t(lower_wavelength,upper_wavelength,time_bandwidth_product)

def lambda_pulse_t(lower_wavelength, upper_wavelength, time_bandwidth_product=0.44):
    """Convert a center wavelength and a spectral width to a pulse duration
       asuming a transform limited pulse with a certain time bandwidht product.
       
       The default time bandwidth product is for a Gaussian pulse (0.44).
       Other time bandwith products are:
       - Sech^2 shaped pulse: 0.315
    """
    return time_bandwidth_product/float(lambda_f(lower_wavelength) - lambda_f(upper_wavelength))

#Energy conversion
def E_Ry_J(E_Ry):
	"""convert energy from Rydbergs to Joules"""
	return E_Ry*(e_cgs**2/(2.0*a0_cgs)*1e-7)

def E_J_Ry(E_J):
	"""convert energy from Joules to Rydbergs"""
	return E_J/(e_cgs**2/(2.0*a0_cgs)*1e-7)

def E_cm_J(E_cm):
	"""convert energy from cm^-1 to Joules"""
	return E_cm*(h_SI*c_SI*100.0)

def E_J_cm(E_J):
	"""convert energy from Joules to cm^-1"""
	return E_J/(h_SI*c_SI*100.0)

def E_cm_Ry(E_cm):
	"""convert energy from cm^1 to Rydbergs"""
	return E_J_Ry(E_cm_J(E_cm))

def E_Ry_cm(E_Ry):
	"""convert energy from Rydbergs to cm^-1"""
	return E_J_cm(E_Ry_J(E_Ry))

def E_J_f(E_J):
	"""convert energy from Joules to frequency in Hz"""
	return E_J/h_SI

def E_f_J(E_f):
	"""convert energy from frequency in Hz to Joules"""
	return E_f*h_SI

def E_J_omega(E_J):
	"""convert energy from Joules to frequency in rad/sec"""
	return E_J/hbar_SI

def E_omega_J(E_omega):
	"""convert energy from frequency in rad/sec to Joules"""
	return E_omega*hbar_SI

def E_cm_omega(E_cm):
	"""convert energy from wavelength in cm^-1 to frequency in rad/sec"""
	return E_J_omega(E_cm_J(E_cm))
	
def E_omega_cm(E_omega):
	"""convert energy from frequency in rad/sec to wavelength in cm^-1"""
	return E_J_cm(E_omega_J(E_omega))

def E_lambda_omega(E_lambda):
	"""convert a wavelength in m to a frequency in rad/sec"""
	return f_omega(c_SI/E_lambda)

def E_omega_lambda(E_omega):
	"""convert a frequency in rad/sec to a wavelength in m"""
	return c_SI/omega_f(E_omega)

#Electric field conversions
def Ef_Vm_ea0(E_Vm):
	"""convert electric field from V.m^-1 to e.a0^-2 units"""
	return E_Vm/(e_cgs/a0_cgs**2 * c_cgs/1.0e10)
def Ef_ea0_Vm(E_ea0):
	"""convert electric field from e.a0^-2 units to V.m^-1"""
	return E_ea0*(e_cgs/a0_cgs**2 * c_cgs/1.0e10)
	
def Ef_Vm_Wcm2(E_Vm):
	"""convert electric field from V.m^-1 to W.cm^-2"""
	pass
	
def Ef_Wcm2_Vm(E_Wcm2):
	"""convert electric field from W.cm^-2 to V.m^-1"""
	return scipy.sqrt(E_Wcm2*1.0e4*2.0/(c_SI*eps_nul_SI))
	
### convert functions from the Einstein coeff....and all that paper
def convert_A_ki_S(omega, J_k,A_k_i):
	"""   S_i_k = S_k_i = S; omega_i_k = omega_k_i = omega. Test with num. example in "...and all that" paper   """
	g_k = 2.*J_k + 1.
	#print omega, J_k, A_k_i
	#print eps_nul, h, c, omega, g_k, A_k_i
	S = 3.*eps_nul*h*c**3/(2.*omega**3)*g_k*A_k_i
	return S

def convert_A_ki_f_ik(A_ki, omega, J_i, J_k):
	""" f_ik is the absorption oscillator strength, which is greater than zero. Test with num. example in "...and all that" paper"""
	g_i = 2.*J_i + 1.
	g_k = 2.*J_k + 1.
	f_ik = (g_k/g_i)*2*scipy.pi*eps_nul*m_e*c**3*A_ki/(omega**2*e**2)
	return f_ik

def convert_f_ik_S(omega, J_i,f_i_k):
	g_i = 2.*J_i + 1.
	#print g_i, hbar, e, omega, m_e
	S = 3.*g_i*hbar*e**2/(2*omega*m_e)*f_i_k
	return S

def convert_S_mu_k_i(S,J_k):
	g_k = 2.*J_k + 1.
	mu_k_i = scipy.sqrt(S/g_k)
	return mu_k_i

def convert_A_ki_sigma0(lambda_k_i,J_i,J_k,A_ki):
	g_i = 2.*J_i + 1.
	g_k = 2.*J_k + 1.
	sigma0 = g_k/(4.*g_i)*lambda_k_i**2*A_ki
	return sigma0

def convert_sigma0_S(omega,J_i,sigma0):
	g_i = 2.*J_i + 1.
	S = 3.*g_i*eps_nul*hbar*c/(scipy.pi*omega)*sigma0
	return S
	
def convert_B_12omega_S(J_i,B_i_k_omega):
	g_i = 2.*J_i + 1.
	#print g_i, eps_nul, h, hbar,scipy.pi,B_i_k_omega
	S = 3.*g_i*eps_nul*hbar**2/scipy.pi*B_i_k_omega
	return S
	
### dB to fraction conversion functions and dBm to W
def dB_fraction(dB):
    """Convert from dB to a fraction of the compared quantities"""
    return 10.0**(dB/10.0)
    
def fraction_dB(fraction):
    """Convert from a fraction of compared quantities to dB gain"""
    return 10*scipy.log10(fraction)
    
def dBm_W(dBm):
    """Convert from power in dBm to power in W"""
    return 10.0**((dBm-30.0)/10.0)

def W_dBm(W):
    """Convert from power in W to power in dBm"""
    return 10.0*scipy.log10(W)+30.0

def dBm_V_rms(dBm, impedance=50.0):
    """Convert from power in dBm to an RMS voltage into a certain load impedance
       in Ohm (defaults to 50 Ohms).
    """
    return scipy.sqrt(dBm_W(dBm)*impedance)

def V_rms_dBm(V_rms, impedance=50.0):
    """Convert from an RMS voltage to a power in dBm into a certain load impedance
       in Ohm (defaults to 50 Ohms).
    """
    return W_dBm((V_rms**2)/impedance)

def dBm_V_pp(dBm, impedance=50.0):
    """Convert from power in dBm to a peak-to-peak voltage into a certain load
       impedance in Ohm (defaults to 50 Ohms).
    """
    return 2.0*scipy.sqrt(2.0)*dBm_V_rms(dBm, impedance)

def V_pp_dBm(V_pp, impedance=50.0):
    """Convert from a peak-to-peak voltage to a power in dBm into a certain
       impedance in Ohm (defaults to 50 Ohms).
    """
    return V_rms_dBm(V_pp/(2.0*scipy.sqrt(2.0)), impedance)

def I_rms_dBm(I_rms, impedance=50.0):
    """Convert from an RMS current to a power in dBm into a certain load
    impedance in Ohm. (defaults to 50 Ohms)
    """
    return W_dBm((I_rms**2)*impedance)

def dBm_I_rms(dBm, impedance=50.0):
    """Convert from a power in dBm into a certain load impedance (default 50 Ohm)
    to an RMS current (in Amperes).
    """
    return scipy.sqrt((dBm_W(dBm)/impedance))
    
def I_pp_dBm(I_pp, impedance=50.0):
    """Convert from a peak-peak current (in Amperes) into a certain impedance
    (default 50 Ohm) to a power in dBm.
    """
    return I_rms_dBm(I_pp/(2.0*scipy.sqrt(2.0)), impedance)

def dBm_I_pp(dBm, impedance=50.0):
    """Convert from a power in dBm into a certain impedance (default 50 Ohm) to
    a peak-peak current (in Amperes).
    """
    return 2.0*scipy.sqrt(2.0)*dBm_I_rms(dBm, impedance)

### Thermistor calculations with beta and Steinhart-Hartl
def T_R_beta(beta, R0, T0, T, kelvin=False):
    """Calculate a thermistor resistance for a given temperature from the beta
    model, input parameters are:
        beta: temperature coefficient
        R0: resistance at temperature T0 (in Ohm)
        T0: temperature for R0 (in K)
        T: temperature for which we want to calculate the resistance (in K)
        kelvin: if True, temperatures are in Kelvin, otherwise in deg. C
    
    returns: resistance in Ohm
    """
    if not kelvin:
        T0=T0-T_zero_C
        T=T-T_zero_C
    return R0*scipy.exp(float(beta)*(1.0/T-1.0/T0))

def R_T_beta(beta, R0, T0, R, kelvin=False):
    """Calculate a temperature for a given resistance from the beta model, input
    parameters are:
        beta: temperature coefficient
        R0: resistance at temperature T0 (in Ohm)
        T0: temperature for R0 (in K)
        R: resistance for which we want to calculate the temperature (in K)
        kelvin: if True, temperatures are in Kelvin, otherwise in deg. C
    
    returns: temperature
    """
    if not kelvin:
        T0=T0-T_zero_C
    temperature=1.0/(1.0/T0 + scipy.log(R/R0)*1.0/float(beta))
    if not kelvin:
        temperature+=T_zero_C
    return temperature
    
def R_Steinhart_Hart(C1, C2, C3, T, kelvin=False):
    """Calculate the thermistor resistance given Steinhart-Hart coefficients and
    a temperature. Parameters are:
        C1, C2, C3: Steinhart-Hart coefficients
        T: temperature
        kelvin: if True, temperatures are in Kelvin, otherwise in deg. C
          
    returns: resistance in Ohm  
    """
    if not kelvin:
        T=T-T_zero_C
    y=(C1-1.0/T)/C3
    x=scipy.sqrt((C2/(3.0*C3))**3.0+(y**2.0)/4.0)
    return scipy.exp((x-y/2.0)**(1.0/3.0)-(x+y/2.0)**(1.0/3.0))

def T_Steinhart_Hart(C1, C2, C3, R, kelvin=False):
    """Calculate the thermistor temperature given Steinhart-Hart coefficients and
    a resistance. Parameters are:
        C1, C2, C3: Steinhart-Hart coefficients
        R: resistance (in Ohm)
        kelvin: if True, temperatures are in Kelvin, otherwise in deg. C
    
    returns: temperature
    """
    temperature=1.0/(C1 + C2*scipy.log(R) + C3*scipy.log(R)**3.0)
    if not kelvin:
        temperature+=T_zero_C
    return temperature
    
###reflection and transmission at a surface
def theta_t_ni_nt_theta_i(n_i=1.0, n_t=1.5, theta_i=0):
    """Angle of transmission for a light beam passing an interface from a
    material with index ni (incident) to a material with index nt (transmitted)
    with an angle of incidence theta_i to the surface normal.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    theta_i: angle of incidence in rad (with regard to the surface normal).
    
    returns: angle of transmission (with regard to the surface normal)
    """
    return scipy.arcsin(scipy.sin(theta_i)*float(n_i)/float(n_t))

def R_ni_nt(n_i=1.0, n_t=1.5):
    """Reflection coefficient for a beam of light falling in perpendicular to 
    the surface. See e.g. Hecht eq. 4.67.

    NOTE: if the beam falls in under an angle with the surface normal, use the
    appropriate function for perpendicular or parallel polarization.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    
    returns: transmission coefficient
    """
    return ((n_t-n_i)/(n_t+n_i))**2

def T_ni_nt(n_i=1.0, n_t=1.5):
    """Transmission coefficient for a beam of light falling in perpendicular to 
    the surface. See e.g. Hecht eq. 4.68.

    NOTE: if the beam falls in under an angle with the surface normal, use the
    appropriate function for perpendicular or parallel polarization.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    
    returns: transmission coefficient
    """
    return (4.0*n_t*n_i)/(n_t+n_i)**2

def Rpar_ni_nt_theta(n_i=1.0, n_t=1.5, theta_i=0):
    """Reflection coefficient for reflection of a light beam on a surface with
    the E field parallel to the plane of incidence (see e.g. Hecht paragraph
    4.6.2 and equation 4.34). Default refractive index values are for glass.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    theta_i: angle of incidence in rad (with regard to the surface normal).
    
    returns: reflection coefficient
    """
    theta_t=theta_t_ni_nt_theta_i(n_i, n_t, theta_i)
    
    r=(n_t*scipy.cos(theta_i)-n_i*scipy.cos(theta_t)) / (n_i*scipy.cos(theta_t) + n_t*scipy.cos(theta_i))
    
    return r**2

def Tpar_ni_nt_theta(n_i=1.0, n_t=1.5, theta_i=0):
    """Transmission coefficient for a light beam transmitted through a surface with
    the E field parallel to the plane of incidence (see e.g. Hecht paragraph
    4.6.2 and equation 4.34). Default refractive index values are for glass.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    theta_i: angle of incidence in rad (with regard to the surface normal).
    
    returns: transmission coefficient
    """
    return 1.0-Rpar_ni_nt_theta(n_i, n_t, theta_i)

def Rperp_ni_nt_theta(n_i=1.0, n_t=1.5, theta_i=0):
    """Reflection coefficient for reflection of a light beam on a surface with
    the E field parallel to the plane of incidence (see e.g. Hecht paragraph
    4.6.2 and equation 4.34). Default refractive index values are for glass.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    theta_i: angle of incidence in rad (with regard to the surface normal).
    
    returns: reflection coefficient
    """
    theta_t=theta_t_ni_nt_theta_i(n_i, n_t, theta_i)
    
    r=(n_i*scipy.cos(theta_i)-n_t*scipy.cos(theta_t)) / (n_i*scipy.cos(theta_i) + n_t*scipy.cos(theta_t))
    
    return r**2
    
def Tperp_ni_nt_theta(n_i=1.0, n_t=1.5, theta_i=0):
    """Transmission coefficient for a light beam transmitted through a surface with
    the E field parallel to the plane of incidence (see e.g. Hecht paragraph
    4.6.2 and equation 4.34). Default refractive index values are for glass.
    
    n_i: index of refraction of the material in which the incident beam travels
    n_t: index of refraction of the material in which the transmited beam travels
    theta_i: angle of incidence in rad (with regard to the surface normal).
    
    returns: transmission coefficient
    """
    return 1.0-Rperp_ni_nt_theta(n_i, n_t, theta_i)
    
