all:
	mkdir -p /home/lleodev/data/mariadb
	mkdir -p /home/lleodev/data/wordpress
	docker compose -f srcs/docker-compose.yml up -d --build

clean:
	docker compose -f srcs/docker-compose.yml down

fclean: clean
	docker rm -v -f mariadb
	docker rm -v -f wordpress
	docker rm -v -f nginx
	rm -rf /home/lleodev/data
	rm -rf /home/lleodev/data/wordpress

re: fclean all

.PHONY: all clean fclean re