import pytest
from selenium import webdriver
from pageObjects.LoginPage import Login
import time
from utilities.readProperties import Configurations


class Test_001_Login:
    baseURL = Configurations.readURL()
    username = Configurations.readUsername()
    password = Configurations.readPassword()
    firstPagetitle = "Your store. Login"
    secondPageTitle = "Dashboard / nopCommerce administration"

    def test_homePageTitle (self,setup):
        self.driver = setup
        self.driver.get(self.baseURL)
        title_of_the_page = self.driver.title

        if self.firstPagetitle == title_of_the_page:
            assert True
        else:
            self.driver.save_screenshot("./Screenshots/fail1.png")
            self.driver.close()
            assert False

    def test_login(self,setup):
        self.driver = setup
        self.driver.get(self.baseURL)
        self.lp = Login(self.driver)
        self.lp.setUserName(self.username)
        self.lp.setPawssword(self.password)
        self.lp.clickLogin()
        time.sleep(3)
        act_title=self.driver.title
        if self.secondPageTitle == act_title:
            assert True
        else:
            self.driver.save_screenshot("./Screenshots/fail2.png")
            self.driver.close()
            assert False
        