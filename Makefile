VERSION:=0.1.5

package.box:
	vagrant package

release:package.box
	vagrant cloud publish honeytrap15/centos77-postgresql96 $(VERSION) virtualbox package.box

clean:
	rm package.box
