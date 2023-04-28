import subprocess
import pathlib
import getpass


global BASE_PATH
BASE_PATH = "/home"
WORDPRESS_PATHS = []
TIMEOUT = 40
EXCLUDED_PATHS = []
global ALREADY_UPDATED
ALREADY_UPDATED = []

def plugin_finder(plugin_name):
    try:
        global WORDPRESS_PATHS
        global EXCLUDED_PATHS
        BASE_PATH

        wordpress_installations = subprocess.run(
            args=[f"wp find {BASE_PATH} --fields=wp_path --format=csv"], shell=True, capture_output=True, check=True, timeout=TIMEOUT)
        if wordpress_installations.returncode == 0:
            paths = wordpress_installations.stdout.decode().split('\n')
            paths = paths[1:-1]
            if paths:
                for path in paths:
                    WORDPRESS_PATHS.append(pathlib.Path(path))
                    print(path)

        exclude_promt = str(
            input("\nDo you want to exclude any directories [Y/n] : ")).lower()
        if exclude_promt == 'y':
            exclude_num = int(
                input("Enter the Number of directories you need to exclude : ").strip())
            if exclude_num and exclude_num > 0:
                print("Enter the paths to be excluded seperated by a Newline ")
                for i in range(0, exclude_num):
                    exclude_path = input().split()
                    exclude_path = exclude_path[0].strip()
                    exclude_path = pathlib.Path(exclude_path)
                    EXCLUDED_PATHS.append(exclude_path)
            print("\nExcluding paths")
        if EXCLUDED_PATHS:
            WORDPRESS_PATHS = set(WORDPRESS_PATHS) - set(EXCLUDED_PATHS)

        found_list = []
        if WORDPRESS_PATHS:
            for path in WORDPRESS_PATHS:
                finder = subprocess.run(
                    args=[f"wp plugin list --path={path}"], capture_output=True, text=True, timeout=TIMEOUT, shell=True)
                if finder.stderr:
                    print(finder.stderr)
                finder = list(finder.stdout.split())
                finder = [item.strip() for item in finder]

                for i,word in enumerate(finder):
                    if str(plugin_name).lower() == str(word).lower():
                        data = []
                        data.append(path)
                        data.append(finder[i+3])
                        found_list.append(data)

        return found_list

    except subprocess.CalledProcessError as err:
        raise Exception(f"Could not run plugin_finder due to error {err}")


def plugin_updater(plugin_name, plugin_version, path_list):
    try:
        print("Starting Plugin Updation Process...")
        updated_list = []

        print("Please enter the Sudo Password for your privileged account")
        password = getpass.getpass()


        for data in path_list:

            path = data[0]
            current_version = data[1]
            print(f"\n{path}\n")

            if current_version == plugin_version:
                print(f"Version {plugin_version} is already installed")
                ALREADY_UPDATED.append(path)
                continue

            argument = str(path).rstrip("/") + "/wp-content/*"
            
            permisson_arg = "sudo find " + argument + " -type f -exec chmod 666 {} \; && sudo find " + argument + " -type d -exec chmod 777 {} \;"

            proc = subprocess.Popen(args=permisson_arg, stdin=subprocess.PIPE,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            output, error = proc.communicate(input=password.encode())

            if error:
                print(error.decode())

            if output:
                print(output.decode())

            if proc.returncode  != 0:
                exit()
                
            if plugin_version:
                print(f"Updating plugin {plugin_name} from version {current_version} to {plugin_version} at {path}\n")
                args = (
                    f"wp plugin update {plugin_name} --version={plugin_version} --path={path}")
            else:
                print(f"Updating plugin {plugin_name} from version {current_version} to Latest at {path}\n")
                args = [f"wp plugin update {plugin_name} --path={path}"]

            updated = subprocess.run(
                args, capture_output=True, text=True, shell=True, timeout=TIMEOUT)

            if updated.stderr:
                print(f"{updated.stderr}\n")

            if ("success") in str(updated.stdout.lower()):
                updated_version = updated.stdout.split()
                if ('already' in updated_version):
                    print(f"Plugin is already at the latest version")
                if len(updated_version) > 20 :
                    if (updated_version[0] != 'Installing'):
                        updated_version.index("new_version") 
                        index = int(updated_version.index("new_version"))+4
                        updated_version =  updated_version[index]
                    else:
                        updated_version = plugin_version

                    print(f"Plugin {plugin_name} updated from version {current_version} to {updated_version}\n")
                updated_list.append(path)

            permisson_arg = "sudo find " + argument + " -type f -exec chmod 644 {} \; && sudo find " + argument + " -type d -exec chmod 755 {} \;"


            proc = subprocess.Popen(args= permisson_arg, stdin=subprocess.PIPE,
                                    stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
            output, error = proc.communicate(input=password.encode())

            if error:
                print(error.decode())

            if output:
                print(output.decode())

        return updated_list

    except subprocess.CalledProcessError as err:
        raise Exception(f"Could not update the plugin due to error {err}")
    


def wp_cli_install():
    try:

        print("Please enter the Sudo Password for your account")
        password = getpass.getpass()


        subprocess.run(args=[
                       "curl", "-O", "https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar"])
        subprocess.run(args=["chmod", "+x", "wp-cli.phar"])
        proc = subprocess.Popen(args="sudo mv wp-cli.phar /usr/local/bin/wp", stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        output, error = proc.communicate(input=password.encode())

        if error:
            print(error.decode())

        if output:
            print(output.decode())

        installed = subprocess.run(
            args=["wp", "--info"], capture_output=True, text=True)
        wp_find = subprocess.run(
            args=["wp package install wp-cli/find-command"], capture_output=True, text=True)
        if wp_find.returncode != 0:
            print("Could not  install 'wp find' package \nPlease install manually using the command 'wp package install wp-cli/find-command'")
        return installed.returncode

    except subprocess.CalledProcessError as err:
        raise Exception(f"Could not install wp-cli due to error {err}")


def wp_cli_check():
    try:
        installed = subprocess.run(
            args=["wp", "--info"], capture_output=True, text=True)
        if installed.returncode == 0:
            wp_find = subprocess.run(
                args=["wp find ./"], capture_output=True, shell=True, text=True)
            if wp_find.returncode != 0:
                print("Could not  install 'wp find' package \nPlease install manually using the command 'wp package install wp-cli/find-command'")
                return wp_find.returncode
            return installed.returncode
        else:
            print("Please install the wp-cli manually and try again")
            wp_install_status = wp_cli_install()
            return wp_install_status
    except FileNotFoundError:
        wp_install_status = wp_cli_install()
        return wp_install_status


def main_caller():
    try:
        global BASE_PATH
        user_plugin_name = input("Enter the plugin name : ").strip()
        user_plugin_version = input("Enter the plugin version : ").strip()
        base_path = str(input(
            "Enter the Base path for start searching without the trailing slash: ")).strip()
        is_dir = False
        if base_path:
            is_dir = pathlib.Path(base_path).is_dir()
            if is_dir == True:
                BASE_PATH = base_path

        print("If the script fails due to timeout error please update the TIMEOUT variable in the script\n")
        wp_check = wp_cli_check()
        if wp_check == 0:
            found_list = plugin_finder(user_plugin_name)
            if found_list:
                print("Please note that after this update all the directories and files under wp-content directory will have a 755 and 644 permissions respectively")
                final_updated_list = plugin_updater(
                    user_plugin_name, user_plugin_version, found_list)

                if final_updated_list:
                    print(
                        f"\nSuccessfully updated the plugin {user_plugin_name} in the following locations:")
                    for path in final_updated_list:
                        print(str(path))
                
                found_list = [data[0] for data in found_list]

                failed_update = set(found_list) - set(final_updated_list)
                failed_update = set(failed_update) - set(ALREADY_UPDATED)

                if ALREADY_UPDATED:
                    print(
                        f"\nPlugin {user_plugin_name} is already up-to-date in the following locations:")
                    for path in ALREADY_UPDATED:
                        print(str(path))
                        
                if failed_update:
                    print(
                        f"\nFailed to update the plugin {user_plugin_name} in the following locations:")
                    for path in failed_update:
                        print(str(path))

            else:
                print(
                    f"\nCould not find any installed versions of {user_plugin_name}")
        else:
            print("Could not find wp-cli in the server")
            exit()
    except Exception as err:
        raise Exception(f"Script execution failed due to error {err}")


main_caller()
