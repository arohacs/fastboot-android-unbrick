


# The purpose of this project is to provide an unbricking method to those who either can't run the MSM tool, can't get the phone into EDL mode, or are otherwise blocked. 

This tutorial is for using fastboot to unbrick your phone because nothing else has worked and you cannot use or don't have a Windows installation on hardware and can't use the [MSM tool](https://xdaforums.com/t/op7t-oos-11-0-5-1-hd65aa-ba-unbrick-tool-to-restore-your-device-to-oxygenos.3994835/)


All credit for the fastboot commands and process goes to xdaforums.com user: [coomac](https://xdaforums.com/m/coomac.3933373/)

Here is the [Original xdaforums post](https://xdaforums.com/t/guide-unbrick-or-restore-to-oos-using-only-fastboot.4289013/) that  [coomac](https://xdaforums.com/m/coomac.3933373/) created.  

#
# Use this method at your own risk! 


To understand whether you need this project/tool to overcome your current challenges with your android phone, here are a few questions to consider:
1. Do you have a windows OS running on hardware? If so, you should use the [MSM tool](https://xdaforums.com/t/op7t-oos-11-0-5-1-hd65aa-ba-unbrick-tool-to-restore-your-device-to-oxygenos.3994835/) to unbrick.
    - if that isn't working out, keep reading, and also install tools for your Windows OS from [here](https://developer.android.com/tools/releases/platform-tools)

1. Do you have android developer tools such as adb, fastboot, etc?
    1. instructions for Mac: 
        - Homebrew
            - install [homebrew](https://brew.sh/)
            ```
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            ```

            - install [android commandline tools](https://formulae.brew.sh/cask/android-commandlinetools)
                - `brew install --cask android-commandlinetools`
        - use a DMG package
            - download from [here](https://developer.android.com/tools/releases/platform-tools)
            - follow the instructions for general macos package installation
    2. instructions for Linux
        - depending on your OS/flavor, this will likely be managed by your package manager
            - e.g. Arch Linux would be something like: 
                - [installer package](https://aur.archlinux.org/packages/android-sdk-platform-tools)
                    - and then you need a package manager like [yay](https://github.com/Jguer/yay) 
                        - and then it is pretty easy: `yay -Syu android-sdk-platform-tools`
            - ubuntu is going to use [apt](https://ubuntu.com/server/docs/package-management) in most cases unless you have something outside the package manager as a .deb or in a [PPA](https://www.ubuntuupdates.org/ppas)
                - and it'll be something [like](https://www.geeksforgeeks.org/how-to-install-android-tools-adb-on-ubuntu/):
                    ```
                    sudo apt-get update
                    sudo apt-get -y install android-tools-adb
                    ```
            - other linux flavors will have their own package manager, e.g. Red Hat and derivatives will use [rpm](https://rpm.org/)
    1. Do you have a working knowledge of CLI and bash scripts? 
        - I'll give good instructions below, but you can also find free tutorials like [this one](https://www.freecodecamp.org/news/bash-scripting-tutorial-linux-shell-script-and-command-line-for-beginners/) 

If you think you are a candidate for this method of using fastboot to unbrick your phone, keep on reading. 

# Instructions:

1. Get the link from a stock ROM from xdadevelopers for your phone from [here](https://xdaforums.com/t/oneplus-7t-rom-ota-oxygen-os-repo-of-oxygen-os-builds.3997037/#post-80776395)

1. install payload-dumper-go
https://github.com/ssut/payload-dumper-go

    - Follow the instructions for your operating system [here](https://github.com/ssut/payload-dumper-go) to install payload-dumper-go

1. ## Try this the easy way with one script to rule them all
    - run main.sh like this:
        ```
        ./main.sh <your_URL>        
        ```
    - it might look something like: 
        ```
        ./main.sh https://gauss-otacostmanual-sg.allawnofs.com/remove-ea7d9b8443aa1c883bcffb172695ec0d/ota/22/06/27/e18dfda5-a981-43cc-b863-49c203720862.zip
        ```
    - the scripts should do everything except lock your bootloader. See instructions below for that step.

    #
        If that doesn't really work out for you
    #

4. ## Run the scripts the hard way
    1. payload-dumper
        - run the `dump-payload.sh` script like this:
            - `bash dump-payload.sh`  

    1. If you need to, Flash TWRP and boot images

        - Instructions for flashing twrp

            - Go [here]y and find your device
                - As of February 2025, for one plus 7t the link is [here](https://twrp.me/oneplus/oneplus7t.html)

        - Download your [TWRP](https://twrp.me/) image


        - assuming your fastboot tool works properly? 
            - did you test? 
                ```
                ❯ which fastboot
                /opt/homebrew/bin/fastboot
                
                ❯ fastboot
                fastboot: usage: no command
                ```
            - get help like this:
                ```❯ fastboot help```
                

        1. If that all looks good, flash your TWRP image:

            `fastboot flash recovery <twrp_image>`
            
            e.g. 

            `fastboot flash recovery twrp-3.7.0_11-0-hotdog.img`

        1. Flash the boot image from your extract:

            `fastboot flash boot boot.img`

    1. `flash-images-1.sh` stage

        - check your images name against the images in `flash-images-1.sh` and edit as needed. If you run the scripts and you receive errors that an image wasn't found, make sure it really exists and comment out lines as needed.


        1. When ready, run: `bash flash-images-1.sh <your_url>`

    1. `flash-xbl` stage:

        - gather info, if needed or desired
            - If you can run ADB, run `get-props.sh`
            `bash get-props.sh`
            then get the exit code:
            `echo $?`
            If the exit code is zero, you have: LPDDR4X chips 
            e.g. https://www.phonescoop.com/phones/phone.php?p=6132

            If the exit code is 1, you have LPDDR5 chips.

        - As far as it is known, the oneplus 7t has LPDDR4X chips.

        - Run 
            ```
            bash flash-xbl-op7t.sh images
            ``` 
    1. Delete logical partitions
        - If you are confident, skip to the next section to delete the logical partitions.
        - If you are tentative, run `bash get-var.sh` to get all variables, and follow the advice from the original xda post: https://xdaforums.com/t/guide-unbrick-or-restore-to-oos-using-only-fastboot.4289013/ 

            > This next section will clear the super partition (contains odm, system, system_ext, vendor and product). It's not absolutely necessary, so you can skip to the next step. Clearing the super partition will help avoid the following error, which can come up if you had manually flashed ROMs on both slots previously.

                
                Resizing '<partition name>'              FAILED (remote: 'Not enough space to resize partition')
                Example: Resizing 'product'                          FAILED (remote: 'Not enough space to resize partition')
                

            > If you've ever had this error or you just want to be sure that everything is cleared: before deleting, you can check the names of the logical partitions on your phone using fastboot getvar all. Scroll up to the section that looks like this:

                Code:
                ```
                (bootloader) is-logical:odm_a:yes
                (bootloader) is-logical:product_a:yes
                (bootloader) is-logical:system_a:yes
                (bootloader) is-logical:system_ext_a:yes
                (bootloader) is-logical:vendor_a:yes
                ```
                or
                ```
                (bootloader) is-logical:odm_b:yes
                (bootloader) is-logical:product_b:yes
                (bootloader) is-logical:system_b:yes
                (bootloader) is-logical:system_ext_b:yes
                (bootloader) is-logical:vendor_b:yes
                ```

            > As @Matt85m pointed out, you may also have:

                Code:
                ```
                (bootloader) is-logical:odm:yes
                (bootloader) is-logical:product:yes
                (bootloader) is-logical:system:yes
                (bootloader) is-logical:system_ext:yes
                (bootloader) is-logical:vendor:yes
                ```

            > It is also possible to have logical partitions with the same names ending in -cow (system_a-cow, system_b-cow, system_ext_b-cow, vendor_a-cow, product_b-cow, etc). These are created by various ROMs during an OTA. Shout out to @mslezak for the discovery.

    1. Delete all logical partitions:
        ```
        bash clear-all-partitions.sh
        ```
        - If you need to clean up of cow partitions, whatever those are:

        ```
        fastboot delete-logical-partition system_a-cow
        ```

        - You can look for those by running `bash get-var.sh`, as in the above instructions


    1. Create the logical partitions. 
        ```
        bash recreate-partitions.sh
        ```

    1. Flash the next images:
        ```
        bash flash-images-2.sh images
        ```
    #
        And that should unbrick your phone.
    #
## Bonus section: relock your bootloader
You can't peform this flash in fastbootd as it will fail.

Do the following: 

1. From the "Hello" screen, set up the phone offline with no network or account

1. Unlock developer mode
    - This method could vary based on device but generally, go to system, then press "build version" until it unlocks.
1. Turn on adb debugging so that your phone may connect  
    - go into developer settings and check: adb debugging

1. Boot into ADB

    - run `adb devices` 
        - you should see your device
    - run `adb reboot recovery`
    - your phone should reboot into recovery mode
    - run `adb devices` to verify the phone is connected
    - run `adb reboot fastboot` to boot into regular fastboot (you do not want fastbootd)
    - run `fastboot flashing lock`
        - you'll receive a message on your phone asking if you want to lock.
        - use the arrows to select and then lock the bootloader.

        - Your phone will reboot and wipe. This is expected.
        - When your phone reboots, you will not see the warning that your bootloader is unlocked, and now you you can sell your phone, send it in for a rebate, or whatever you had planned before it was bricked.
