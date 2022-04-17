DAEMON=verusd
CLI=verus
B1_FLAGS=-chain=VRSCTEST -ac_halving=123456 # to prevent connecting to real testnet
B2_FLAGS=-chain=VRSCTEST -ac_halving=123456
B1=-datadir=1 $(B1_FLAGS)
B2=-datadir=2 $(B2_FLAGS)
BLOCKS=1
ADDRESS=
AMOUNT=
ACCOUNT=

start:
	$(DAEMON) $(B1) -daemon
	$(DAEMON) $(B2) -daemon

start-gui:
	$(BITCOINGUI) $(B1) &
	$(BITCOINGUI) $(B2) &

# generate:
# 	$(CLI) $(B1) generate $(BLOCKS)

getinfo:
	$(CLI) $(B1) getinfo
	$(CLI) $(B2) getinfo

sendfrom1:
	$(CLI) $(B1) sendtoaddress $(ADDRESS) $(AMOUNT)

sendfrom2:
	$(CLI) $(B2) sendtoaddress $(ADDRESS) $(AMOUNT)

address1:
	$(CLI) $(B1) getnewaddress $(ACCOUNT)

address2:
	$(CLI) $(B2) getnewaddress $(ACCOUNT)

stop:
	$(CLI) $(B1) stop
	$(CLI) $(B2) stop

clean:
	# find 1/regtest/* -not -name 'server.*' -delete
	# find 2/regtest/* -not -name 'server.*' -delete
	find 1/* -not -name 'vrsctest.conf*' -delete
	find 2/* -not -name 'vrsctest.conf*' -delete

docker-build:
	docker build --tag bitcoin-testnet-box .

docker-run:
	docker run -ti bitcoin-testnet-box
