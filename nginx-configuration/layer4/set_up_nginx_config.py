import argparse


def add_servers_to_allbackend(num, file):
    for i in range(1, num + 1):
        file.write("        server {};\n".format(generate_server_name_and_port(i)))


def handle_template(num):
    with open("./conf.d/nginx-template.conf", "r") as file, open("./conf.d/nginx.conf", "w+") as new_file:
        for line in file:
            new_file.write(line)
            if "upstream allbackend {" in line:
                add_servers_to_allbackend(num, new_file)


def generate_server_name_and_port(num):
    port = 3000

    return "node-server{}:{}".format(num, port)


# add argument to the script
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("num_servers", type=int, help="Number of servers to add")
    args = parser.parse_args()

    handle_template(args.num_servers)
