
from selenium.webdriver.common.by import By

class Login:
    textbox_username_id="Email"
    textbox_password_id="Password"
    button_login_xpath="//button[contains(text(),'Log in')]"
    button_logout_linktext="//button[contains(text(),'Log in')]"


    def __init__(self,driver):
        self.driver = driver


    def setUserName(self,username):
        self.driver.find_element(By.ID,self.textbox_username_id).clear()
        self.driver.find_element(By.ID,self.textbox_username_id).send_keys(username)

    def setPawssword(self,password):
        self.driver.find_element(By.ID,self.textbox_password_id).clear()
        self.driver.find_element(By.ID,self.textbox_password_id).send_keys(password)

    def clickLogin(self):
        self.driver.find_element(By.XPATH,self.button_logout_linktext).click()