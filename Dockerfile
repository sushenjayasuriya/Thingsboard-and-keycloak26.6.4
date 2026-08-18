FROM quay.io/keycloak/keycloak:26.6.4

# Copy the custom theme folder (without JARs) to the themes directory
COPY custom-theme /opt/keycloak/themes/custom.v2

# Copy the theme JARs from the custom-theme folder to the providers directory
COPY custom-theme/*.jar /opt/keycloak/providers/

# Copy other providers and realm file
COPY email-authenticator-mesutpiskin.jar /opt/keycloak/providers/
COPY sms-otp-authenticator-266.jar /opt/keycloak/providers/
COPY thingsboard-realm.json /opt/keycloak/data/import/

CMD ["start-dev", "--import-realm"]
