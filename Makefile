all:
	mkdir -p /home/lleodev/data/mariadb /home/lleodev/data/wordpress
	docker compose up -d --build

clean:
	docker compose down

fclean: clean
	rm -rf /home/lleodev/data
	rm -rf /home/lleodev/data/wordpress

re: fclean all

PHONY=all clean fclean re