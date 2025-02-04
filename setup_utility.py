from selenium.webdriver.chrome.service import Service


def get_service(executable_path):
    """
    Returns a Service object for Chrome WebDriver.

    :param executable_path: Path to the Chrome WebDriver executable
    :return: Service object
    """
    return Service(executable_path)