*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***
Scroll Into View
    [Arguments]    ${element}    ${behavior}=auto    ${block}=center
    #    { behavior: 'smooth', block: 'start' }

    #Supported behavior values:
    #'auto' (default):
    #
    #The scrolling happens instantly without any animation or smoothness.
    #This is the default behavior when no behavior is specified.
    #'smooth':
    #
    #The scrolling happens smoothly with animation.
    #'start':
    #
    #Aligns the element to the top of the viewport (default for most cases).
    #'center':
    #
    #Aligns the element in the center of the viewport.
    #'end':
    #
    #Aligns the element to the bottom of the viewport.
    #'nearest':
    #
    #Scrolls the page such that the element is in view but minimizes the scrolling distance. This is useful for optimizing the scrolling behavior.
    ${options}=    Create Dictionary   behavior=${behavior}    block=${block}
    IF    '${behavior}!=auto'
        Set To Dictionary  ${options}    behavior=${behavior}
    END
    IF    '${block}!=start'
        Set To Dictionary  ${options}    block=${block}
    END
        
    Execute JavaScript    arguments[0].scrollIntoView(${options});    ARGUMENTS     ${element}
