import argparse


def add_servers_to_allbackend(num, file):
    for i in range(1, num + 1):
        file.write("        server {};\n".format(generate_server_ip_and_port(i)))


def add_servers_to_app1(app1_servers, file):
    for i in range(1, app1_servers + 1):
        file.write("        server {};\n".format(generate_server_ip_and_port(i)))


def add_servers_to_app2(app1_servers, num, file):
    for i in range(app1_servers + 1, num + 1):
        file.write("        server {};\n".format(generate_server_ip_and_port(i)))


def handle_template(num):
    app1_servers = num // 2
    with open("./conf.d/nginx-template.conf", "r") as file, open("./conf.d/nginx.conf", "w+") as new_file:
        for line in file:
            new_file.write(line)
            if "upstream allbackend {" in line:
                add_servers_to_allbackend(num, new_file)
            elif "upstream app1backend {" in line:
                add_servers_to_app1(app1_servers, new_file)
            elif "upstream app2backend {" in line:
                add_servers_to_app2(app1_servers, num, new_file)


def generate_server_ip_and_port(num):
    port = 3000

    return "node-server{}:{}".format(num, port)


# add argument to the script
if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("num_servers", type=int, help="Number of servers to add")
    args = parser.parse_args()

    handle_template(args.num_servers)
