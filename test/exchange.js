var Exchange = artifacts.require('./Exchange.sol')
var FirstToken = artifacts.require('./FirstToken.sol')
var SecondToken = artifacts.require('./SecondToken.sol')


contract('Exchange', (accounts) => {
    it('should exchange 500 FST tokens to 1000 SND tokens', async () => {
        var acc1 = accounts[0];
        var acc2 = accounts[1];
        var first = await FirstToken.deployed();
        var second = await SecondToken.deployed();
        var exchange = await Exchange.deployed();

        var logBalances = async function () {
            console.log("acc1.FST=" + (await first.balanceOf(acc1)).toNumber());
            console.log("acc1.SND=" + (await second.balanceOf(acc1)).toNumber());
            console.log("acc2.FST=" + (await first.balanceOf(acc2)).toNumber());
            console.log("acc2.SND=" + (await second.balanceOf(acc2)).toNumber());
        }

        await second.transfer(acc2, 1000, {from: acc1});
        console.log("Balances before exchange:");
        logBalances();

        await first.approve(exchange.address, 500, {from: acc1});
        await exchange.exchange(first.address, 500, second.address, 1000, {from: acc1});
        await second.approve(exchange.address, 1000, {from: acc2});
        await exchange.exchange(second.address, 1000, first.address, 500, {from: acc2});

        console.log("Balances after exchange:");
        logBalances();
    })
});