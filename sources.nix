{ fetchurl, requireFile }:

# You can find information about the Quartus software at https://dl.altera.com/.
# To be able able to download anything you must fill out a registration form.
# So the URLs below might not be "stable". (It's probably a good idea to backup
# the downloaded sources.)

# Even when browsing the encrypted HTTPS site (https://dl.altera.com/) the
# download links are given as unencrypted http://. Trying to use https://
# instead results in a browser warning, because the certificate is not trusted
# (checked 2017-08).

# Old versions of Quartus were named "Quartus II" and came in two editions:
#   * web (free)
#   * subscription (paid license)
#
# New versions (since 15.1) are named "Quartus Prime" and come in these
# editions:
#   * lite (free, same as old web
#   * standard (paid license, similar to subscription)
#   * pro (paid license, similar to subscription)
#
# Summary:
#   free = web | lite
#   paid1 = subscription | standard
#   paid2 = pro   # exists since 15.1

# Comments like
#   # Size: 1.5 GB MD5: 672AD34728F7173AC8AECFB2C7A10484
# come from dl.altera.com. Nix doesn't consider md5 secure, so we use sha256
# instead. Use a human to verify sha256 -> md5 sums. For example, this command
# outputs the md5 sums for the Quartus Prime 16 Standard Edition components, as
# is, in the nix store:
# $ nix-build -A altera-quartuses.sources.v16.standard | while read f; do md5sum "$f"; done

let requireQuartus =
    { name
    , sha256
    }: requireFile
       { name = name;
         sha256 = sha256;
         message = ''
             Download the quartus artifact ${name} from Intel's FPGA download
             center, then add it to the store with:

             nix-store --add-fixed sha256 ${name}
         '';
       };
in {

  v14 = rec {
    version = "14.1.0.186";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/14.1/186/ib_installers";

    web_edition = {
      baseName = "altera-quartus-ii-web";
      prettyName = "Quartus II Web Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 1.5 GB MD5: A9237345C5725418A72363CDFF2556A7
          url = "${baseUrl}/QuartusSetupWeb-${version}-linux.run";
          sha256 = "0ngm9mib5dk8rivqrnds8ckp4p5yhh8i5yny4bhaixrf8jzibqk6";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 70BE49AF8A26D4345937ED6BE4D568C8
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "0wdxcyhwrb4kcdcgw3s4md2wbmpzywwqgm3ajmmilcxdfz0xkijm";
        };
        arria = fetchurl {
          # Size: 497.7 MB MD5: B329C8FCC2E1315B0E36C11AD41A23F7
          url = "${baseUrl}/arria_web-${version}.qdz";
          sha256 = "1x1dv2shlm0za8is9kk441vhlm3l61n5vqxmpn1ppvmy26dknlsp";
        };
        cyclone = fetchurl {
          # Size: 462.7 MB MD5: 599819EBE4DDBFA0B622505B22432E86
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "01wb8byxmiyaxazk9ww1bf7milmy5gnbvxw8ss1b50f2dc7724bm";
        };
        cyclonev = fetchurl {
          # Size: 1.0 GB MD5: 446D7EE5999226CD3294F890A12C53CC
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "1jvcnd71wpy7aldxpqjshc53rwmwzghbk5ka2qmjk206yhjb84sm";
        };
        max = fetchurl {
          # Size: 11.3 MB MD5: C3EDC556AC9770DB2DD63706EECA2654
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "0p1b4gw53lj70nsic1ydh8fkp7bpz0a3kk7bs6zqvphzh37aqsyy";
        };
        max10 = fetchurl {
          # Size: 289.0 MB MD5: 75F2D4AF1E847FC53AC6B619A35BD2CF
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0s8lyy168d6979wpnfwfk0ffyq8bspm77xzdwdwbmv6xq8l9bpz3";
        };
      };
    };

    subscription_edition = {
      baseName = "altera-quartus-ii-subscription";
      prettyName = "Quartus II Subscription Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.2 GB MD5: 5A4696ED4AC2970897DC29714A7ECF5A
          url = "${baseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "14k6jshw8nni393h2v9yians4cqmqx959gilpjqd3sbl2mi84nla";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 70BE49AF8A26D4345937ED6BE4D568C8
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "0wdxcyhwrb4kcdcgw3s4md2wbmpzywwqgm3ajmmilcxdfz0xkijm";
        };
        arria = fetchurl {
          # Size: 664.8 MB MD5: F1ACD701CC473FBC5683F4A0C6372211
          url = "${baseUrl}/arria-${version}.qdz";
          sha256 = "08iv0k46brb74pv9lyddmbnbsyisa0icccdvmixhzaygk7a7cv7n";
        };
        arriav = fetchurl {
          # Size: 1.3 GB MD5: 87B7D003DAF8787CE62993E37054D043
          url = "${baseUrl}/arriav-${version}.qdz";
          sha256 = "0qq8y895qspqalbgp2h37rmj7kphwb4245nc6dyjf7v5wjxs485x";
        };
        arriavgz = fetchurl {
          # Size: 1.9 GB MD5: A6F8A84CE77DDE6ABC4B50CC02A64DCB
          url = "${baseUrl}/arriavgz-${version}.qdz";
          sha256 = "1qq03rkxv724yvl47vv0n7r9n091kc1gnsd0kls38a8knqc0mfdg";
        };
        arria10 = fetchurl {
          # Size: 3.5 GB MD5: 8DC178E805F176BFD7119135B6A4B33E
          url = "${baseUrl}/arria10-${version}.qdz";
          sha256 = "0r9q8w5prd32hj52796vaiqp7f62cqfifcf4cv0vdpnsk2mm4w8v";
        };
        cyclone = fetchurl {
          # Size: 462.7 MB MD5: 599819EBE4DDBFA0B622505B22432E86
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "01wb8byxmiyaxazk9ww1bf7milmy5gnbvxw8ss1b50f2dc7724bm";
        };
        cyclonev = fetchurl {
          # Size: 1.0 GB MD5: 446D7EE5999226CD3294F890A12C53CC
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "1jvcnd71wpy7aldxpqjshc53rwmwzghbk5ka2qmjk206yhjb84sm";
        };
        max = fetchurl {
          # Size: 11.3 MB MD5: C3EDC556AC9770DB2DD63706EECA2654
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "0p1b4gw53lj70nsic1ydh8fkp7bpz0a3kk7bs6zqvphzh37aqsyy";
        };
        max10 = fetchurl {
          # Size: 289.0 MB MD5: 75F2D4AF1E847FC53AC6B619A35BD2CF
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0s8lyy168d6979wpnfwfk0ffyq8bspm77xzdwdwbmv6xq8l9bpz3";
        };
        stratixiv = fetchurl {
          # Size: 535.0 MB MD5: 54260F8123D9AAFA5AD004D9D223520C
          url = "${baseUrl}/stratixiv-${version}.qdz";
          sha256 = "1qfmkwnrqs41hchblpp7xqiqh80yb9r3fycgl5dpnm9gi5n6hn90";
        };
        stratixv = fetchurl {
          # Size: 2.7 GB MD5: E7B7A4A83E723DA08D19C1DA2F559F4F
          url = "${baseUrl}/stratixv-${version}.qdz";
          sha256 = "0pvnnaifdfbcwgdm0ks06sr8wf3n20692cykmxnkdy7g94lk0hyx";
        };
      };
    };

    # Updates are shared between editions. I.e. this update can be applied to
    # either web or subscription editions.
    updates = rec {
      version = "14.1.1.190";
      updateBaseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/14.1.1/190/update";
      components = {
        quartus = fetchurl {
          # Size: 1.2 GB MD5: AA1623894DE38069635913DA2DE33167
          url = "${updateBaseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "11c1mss09v7sd6mm8sfy4vsxjssdk8xw6cwipnpsg2rrxvaz1v1i";
        };
      };
    };

  };

  v15 = rec {
    version = "15.1.0.185";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/15.1/185/ib_installers";

    lite = {
      baseName = "altera-quartus-prime-lite";
      prettyName = "Quartus Prime Lite Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 1.7 GB MD5: CC8BFDE25F57C2F05D1753882BC9607A
          url = "${baseUrl}/QuartusLiteSetup-${version}-linux.run";
          sha256 = "0g66b97mr2snv5r1rqxxfrphz8bvkpdkccnrl2n7lcckiwj2baxf";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 5A6B6033342D35561F8DF4CE8891CDDB
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1c0nzqbvx8s5shhifdfhcivv8x637gik9hqmvyhhifkqqrb5y8yc";
        };
        arria = fetchurl {
          # Size: 497.7 MB MD5: 48577BD12E186361C7DE923E4CD19074
          url = "${baseUrl}/arria_lite-${version}.qdz";
          sha256 = "0arxpsc0xhsqc6hq89mwxv8xvmm6pq9bv33k8w2kk5x8n9whw4b3";
        };
        cyclone = fetchurl {
          # Size: 463.9 MB MD5: FD95042C8C58782FF6C25C25EA83CA2E
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "1h6ihc8jxshxkw5iin90c5pc5kfqx5r8080cwavvr1rj9y6hif35";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 7F108A307455ACDC3CF6DA21B1FBF211
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "0028qmsbl4zsg9pgj4d72h08rq851yngp4q3p7x3aj80qgvlgwnm";
        };
        max = fetchurl {
          # Size: 11.3 MB MD5: DEACB97D4A14A952521B6F1DFBCB958F
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "108n59j0qn8mpalzh4zrf3zbgik4wy6xg5xil2k6h92fwalwl7hn";
        };
        max10 = fetchurl {
          # Size: 338.9 MB MD5: C132D3689C78B3706B36E2C23A0F8209
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0479aggma94c9b2rvqjvwkgj7s3d455j2nmsbdb2gvp2k2dc5vg0";
        };
      };
    };

    standard = {
      baseName = "altera-quartus-prime-standard";
      prettyName = "Quartus Prime Standard Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.4 GB MD5: EC505B3C9CDB377D0211D3EF0962FBB5
          url = "${baseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "1bly2vsmx7ff7q5bcc13yg30sfpw4csh0zis0gz17vzlj0h8rl9n";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 5A6B6033342D35561F8DF4CE8891CDDB
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1c0nzqbvx8s5shhifdfhcivv8x637gik9hqmvyhhifkqqrb5y8yc";
        };
        arria = fetchurl {
          # Size: 664.8 MB MD5: C4FB92D9DB5581FD3221B33F12FCF20A
          url = "${baseUrl}/arria-${version}.qdz";
          sha256 = "1c8l0sa89qmw65dy0r0w2mnai0b80w5lgaxqj06xwn05v1ll9gr0";
        };
        arria10_part1 = fetchurl {
          # Size: 3.0 GB MD5: D983C1BBB2CDC598E6AF66239C57F5B3
          url = "${baseUrl}/arria10_part1-${version}.qdz";
          sha256 = "1dq626sq8632dqshlxbdw11ycza5s92rcrwargf0mzqvd0jp9wam";
        };
        arria10_part2 = fetchurl {
          # Size: 3.5 GB MD5: 1FB03F3AEF5B2E04281BC3F2EA71929E
          url = "${baseUrl}/arria10_part2-${version}.qdz";
          sha256 = "043lvgv82vlv8wpkkv5dvgp0w5b19667y2ddlddw0345xff43841";
        };
        arria10_part3 = fetchurl {
          # Size: 3.6 GB MD5: F460FC69761C71D2F6AAA5E35FB1FE75
          url = "${baseUrl}/arria10_part3-${version}.qdz";
          sha256 = "1mcahq4y8k75r4vi7fxah1w48s7hriz67s7f8bibv6lhvrxcpa4h";
        };
        arriav = fetchurl {
          # Size: 1.3 GB MD5: C7E26A53F2A916D1E249B0BA45CDA9CB
          url = "${baseUrl}/arriav-${version}.qdz";
          sha256 = "1wqnxz93bs44qpknczhj3cqm2gr9hfwpyzsd9k5dj84wgv74w4ll";
        };
        arriavgz = fetchurl {
          # Size: 1.9 GB MD5: 075D5308C3DEDDDC3C8584BBA40D0211
          url = "${baseUrl}/arriavgz-${version}.qdz";
          sha256 = "1wq5vm7hsxl0l8r6d4v9bcjflh68g7pnall2zfyl2dalk2ccvwad";
        };
        cyclone = fetchurl {
          # Size: 463.9 MB MD5: FD95042C8C58782FF6C25C25EA83CA2E
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "1h6ihc8jxshxkw5iin90c5pc5kfqx5r8080cwavvr1rj9y6hif35";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 7F108A307455ACDC3CF6DA21B1FBF211
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "0028qmsbl4zsg9pgj4d72h08rq851yngp4q3p7x3aj80qgvlgwnm";
        };
        max = fetchurl {
          # Size: 11.3 MB MD5: DEACB97D4A14A952521B6F1DFBCB958F
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "108n59j0qn8mpalzh4zrf3zbgik4wy6xg5xil2k6h92fwalwl7hn";
        };
        max10 = fetchurl {
          # Size: 338.9 MB MD5: C132D3689C78B3706B36E2C23A0F8209
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0479aggma94c9b2rvqjvwkgj7s3d455j2nmsbdb2gvp2k2dc5vg0";
        };
        stratixiv = fetchurl {
          # Size: 534.9 MB MD5: 490E54FDFF0F7C155D8EBECCC3F1A02A
          url = "${baseUrl}/stratixiv-${version}.qdz";
          sha256 = "19skdlcfjdci1slghflzrf18war3al9n4sginvrk09f8ak60i48f";
        };
        stratixv = fetchurl {
          # Size: 2.8 GB MD5: 587F193664F4CCC77D198B2F7DA9E29F
          url = "${baseUrl}/stratixv-${version}.qdz";
          sha256 = "0i31ickji978igm1xj3sh6a2l19ddyyij0knxxiyrlmgwrahg6yx";
        };
      };
    };

    # Updates are shared between editions. I.e. this update can be applied to
    # either lite or standard editions.
    updates = rec {
      version = "15.1.2.193";
      updateBaseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/15.1.2/193/update";
      components = {
        quartus = fetchurl {
          # Size: 4.1 GB MD5: EECCEF76A26E98E8022C59C7491FC215
          url = "${updateBaseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "0vv2ijjxyj0a7pqxqsjs1bvi6aq44bn0ml7inxcg1lrba095cmdl";
        };
      };
    };

  };

  v16 = rec {
    version = "16.1.0.196";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/16.1/196/ib_installers";

    lite = {
      baseName = "altera-quartus-prime-lite";
      prettyName = "Quartus Prime Lite Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.0 GB MD5: 0FFD781FCC23C6FABC6A68019B3CAB62
          url = "${baseUrl}/QuartusLiteSetup-${version}-linux.run";
          sha256 = "0k54sqxycpa3xpq17w260lb3d6fy3yz7jg100vcsyvpizfvlv8cb";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: F665D7016FF793E64F57B08B37487D0E
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1gxip6q2gl59scf6lj8scd9zx3acrphzq7xaniy67rwp7h0p2fzk";
        };
        arria = fetchurl {
          # Size: 499.6 MB MD5: 77E151BBF3876F6110AB94F7C6A68047
          url = "${baseUrl}/arria_lite-${version}.qdz";
          sha256 = "0i7yarx9kkyzhm60gfjgwb23bfhcm0d56zg7jphgcjr1m7ipbhhw";
        };
        cyclone = fetchurl {
          # Size: 466.7 MB MD5: 70A27B31D439D6271650C832A9785F2C
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "043psjc9a99pj4gh11xzk4pvhr1arlf30klw5j95kpm5aqh6cymx";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 8386E6891D17DC1FAF29067C46953FC7
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "1s77m6shqln6vmfqjrnnqdzv62w7ax86vswwhylzmib8g3gpl126";
        };
        max = fetchurl {
          # Size: 11.4 MB MD5: AFC8FF969FBA63E84D5D40AE812F83A2
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "14vk6mazi822nmg6ha9cvx2014bkxhhwrq8z0gfmp88sgwlbsqyk";
        };
        max10 = fetchurl {
          # Size: 331.3 MB MD5: 013AACB391EAD32FF8E094D9D14987C3
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0q6cyxk50ibv1vjc2l62q6kss8z4i3pcy693rhmh96w4vv8fyi62";
        };
      };
    };

    standard = {
      baseName = "altera-quartus-prime-standard";
      prettyName = "Quartus Prime Standard Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.7 GB MD5: D8A1730C18F2D79EB080786FFFE2E203
          url = "${baseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "1zakbah11sjw94112h59bvkkha89kzm3p48iw948r0d0fva01xhr";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: F665D7016FF793E64F57B08B37487D0E
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1gxip6q2gl59scf6lj8scd9zx3acrphzq7xaniy67rwp7h0p2fzk";
        };
        arria = fetchurl {
          # Size: 669.7 MB MD5: C3B3AB6ECA98C260F4EB31E778B4E51F
          url = "${baseUrl}/arria-${version}.qdz";
          sha256 = "0x23pgmb5xxijs2hj58bl7q4k19ni4yjgfxi942xi02myhg3bgyz";
        };
        arria10_part1 = fetchurl {
          # Size: 3.0 GB MD5: 9310F05926BAA61B31D687D8B7B7E669
          url = "${baseUrl}/arria10_part1-${version}.qdz";
          sha256 = "02g76fivcv8lpaybf0347dz2aimdcfn6yirq7xh5y5cknlc3di53";
        };
        arria10_part2 = fetchurl {
          # Size: 3.6 GB MD5: CF548FB5A5CF098FBDE6892E3D92950F
          url = "${baseUrl}/arria10_part2-${version}.qdz";
          sha256 = "001yh8gm35sbwrd1wq6d0w8c98dn5xaz5if5q61hv5sw15cn8cik";
        };
        arria10_part3 = fetchurl {
          # Size: 3.0 GB MD5: 8247BAA0EB689C24C8D681675F44918A
          url = "${baseUrl}/arria10_part3-${version}.qdz";
          sha256 = "0mbzmd7n5g3sidy2rk3wmrjqiwg5b81zmf7a0rl9a96bzgimjl64";
        };
        arriav = fetchurl {
          # Size: 1.3 GB MD5: E0CCEE4BE7C7C926670AAFA9E9FE58A4
          url = "${baseUrl}/arriav-${version}.qdz";
          sha256 = "0san5kc3awsfphldwa8518aydgc42glnz8d96h2izycz3qkwia77";
        };
        arriavgz = fetchurl {
          # Size: 2.0 GB MD5: B82B74B58BCE65CF6D9AFF1AAFDD76BB
          url = "${baseUrl}/arriavgz-${version}.qdz";
          sha256 = "1kv1akkppz7a5j4x14kiz6mlvfk45rc7rg3gwrmg9rwyn93cvrmr";
        };
        cyclone = fetchurl {
          # Size: 466.7 MB MD5: 70A27B31D439D6271650C832A9785F2C
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "043psjc9a99pj4gh11xzk4pvhr1arlf30klw5j95kpm5aqh6cymx";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 8386E6891D17DC1FAF29067C46953FC7
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "1s77m6shqln6vmfqjrnnqdzv62w7ax86vswwhylzmib8g3gpl126";
        };
        max = fetchurl {
          # Size: 11.4 MB MD5: AFC8FF969FBA63E84D5D40AE812F83A2
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "14vk6mazi822nmg6ha9cvx2014bkxhhwrq8z0gfmp88sgwlbsqyk";
        };
        max10 = fetchurl {
          # Size: 331.3 MB MD5: 013AACB391EAD32FF8E094D9D14987C3
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0q6cyxk50ibv1vjc2l62q6kss8z4i3pcy693rhmh96w4vv8fyi62";
        };
        stratixiv = fetchurl {
          # Size: 544.5 MB MD5: 01084D9F216530499664839C51EE129C
          url = "${baseUrl}/stratixiv-${version}.qdz";
          sha256 = "1jxz6rrcvzd6rf9qjwnrxkvggc6ajs62xvzffr3x1k37ildfc81c";
        };
        stratixv = fetchurl {
          # Size: 2.9 GB MD5: C3E7C3569214D412B4E19BE58C89A194
          url = "${baseUrl}/stratixv-${version}.qdz";
          sha256 = "0ibzdb8fhzf0b9jxvqxgmb319gjxc7jplghakqznz6144nshjq44";
        };
      };
    };

    # Updates are shared between editions. I.e. this update can be applied to
    # either lite or standard editions.
    updates = rec {
      version = "16.1.2.203";
      updateBaseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/16.1.2/203/update";
      components = {
        quartus = fetchurl {
          # Size: 2.4 GB MD5: 607E5CBFF6B674034413E675655DDA32
          url = "${updateBaseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "020ind25j4z060cr37gf8344aadqfwvpik1wkmrbrdja3aixn1g8";
        };
      };
    };

  };

  v17 = rec {
    version = "17.1.0.590";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/17.1std/590/ib_installers";

    lite = {
      baseName = "altera-quartus-prime-lite";
      prettyName = "Quartus Prime Lite Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.0 GB MD5: 8A22E65F15B695E7967A292CAA7275F3
          url = "${baseUrl}/QuartusLiteSetup-${version}-linux.run";
          sha256 = "1y8v207903zi367yy6iarqwmywqmw654rc3vgidla21kmqxs5n4k";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 47E17B9DCCE592AD248991660B0B3CD8
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1ilgyyjm3n9h1sybip7ng764g6y7alp32kvxkrjispbm7098xzv6";
        };
        arria = fetchurl {
          # Size: 499.6 MB MD5: EA15FB95662AB632F2CD95A93D995A92
          url = "${baseUrl}/arria_lite-${version}.qdz";
          sha256 = "0ql9k0gsj1jg4c89afjg61gfy1zwmjmpxzjixrjvphiszk6gmadp";
        };
        cyclone = fetchurl {
          # Size: 466.6 MB MD5: 09D346E4AE7AC403DF4F36563E6B7BFB
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "03jk7gsvqi93vyqay12l5vq7sg5ifd5yhycmk2irj0xshpg3x277";
        };
        cyclone10lp = fetchurl {
          # Size: 266.1 MB MD5: C9D4AC6A692BE4C3EAC15473325218BB
          url = "${baseUrl}/cyclone10lp-${version}.qdz";
          sha256 = "0vj5wxplpkhz4bmc0r2dbghnifznw6rm1jqjxqf6bmj23ap6qahq";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 747202966905F7917FB3B8F95228E026
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "0zmd3mkpz3cpclbasjjn8rrcffhsn2f00mw00jya3x259hrvvpcr";
        };
        max = fetchurl {
          # Size: 11.4 MB MD5: 77B086D125489CD74D05FD9ED1AA4883
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "12h6sgqqdjf929mmdis5wad85c5bjmnwlp8xqjxl3hhzd15x1xcd";
        };
        max10 = fetchurl {
          # Size: 325.2 MB MD5: 9B55655054A7EA1409160F27592F2358
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0xwvy7ja637qh7dbf64pxrhqhyr15ws9wdir1zfxwahdw0n1ril5";
        };
      };
    };

    standard = {
      baseName = "altera-quartus-prime-standard";
      prettyName = "Quartus Prime Standard Edition";
      inherit version updates;
      components = {
        quartus = fetchurl {
          # Size: 2.7 GB MD5: 6526114644039D5011AD1FA3960941D1
          url = "${baseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "0kdlkqqi39l1frlf92amafqxfiyhmyljxi2d1wbgmacnr4msh19g";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 47E17B9DCCE592AD248991660B0B3CD8
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "1ilgyyjm3n9h1sybip7ng764g6y7alp32kvxkrjispbm7098xzv6";
        };
        arria = fetchurl {
          # Size: 669.7 MB MD5: 8B3BC0110C9485DDA2EE1B34A74D7B50
          url = "${baseUrl}/arria-${version}.qdz";
          sha256 = "1kmapmgip25jvzkg633zv8x6knbbcr8d512i3lnixn5f12zls4h6";
        };
        arria10_part1 = fetchurl {
          # Size: 3.2 GB MD5: 9543781AE7538DCCB71142625934EB9A
          url = "${baseUrl}/arria10_part1-${version}.qdz";
          sha256 = "11g8ifnas7vbl0kbbk6vzf6wb80kyi37d7w33y3lrwcv5p5g4igg";
        };
        arria10_part2 = fetchurl {
          # Size: 3.6 GB MD5: F80A0EA351CBCF105E74EAC6893B0F56
          url = "${baseUrl}/arria10_part2-${version}.qdz";
          sha256 = "1crglrnlr5ygd825vzjcav4b1difyzi0lys5ffxzqqa0pkr9vbm0";
        };
        arria10_part3 = fetchurl {
          # Size: 4.8 GB MD5: 7B0F872DA6E3F48DCCBD171A588A7546
          url = "${baseUrl}/arria10_part3-${version}.qdz";
          sha256 = "1x43khxxmlvql450m4l4d3c853g0n0zrhwq7ixykyk9z7alkj65q";
        };
        arriav = fetchurl {
          # Size: 1.3 GB MD5: 577D4E4F470930AB8054C1AC88F24FB7
          url = "${baseUrl}/arriav-${version}.qdz";
          sha256 = "16fk0k26dqsxn7gwwb1f9fr96h1nj2yy48bhrwji7kb9bmwydys7";
        };
        arriavgz = fetchurl {
          # Size: 2.0 GB MD5: 62DA0E43F4F6147646901611CE7CA043
          url = "${baseUrl}/arriavgz-${version}.qdz";
          sha256 = "02r5r66m6kj3zriyvshrd02mp4njpa1jack6bh4zdbr936wriiw3";
        };
        cyclone = fetchurl {
          # Size: 466.6 MB MD5: 09D346E4AE7AC403DF4F36563E6B7BFB
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "03jk7gsvqi93vyqay12l5vq7sg5ifd5yhycmk2irj0xshpg3x277";
        };
        cyclone10lp = fetchurl {
          # Size: 266.1 MB MD5: C9D4AC6A692BE4C3EAC15473325218BB
          url = "${baseUrl}/cyclone10lp-${version}.qdz";
          sha256 = "0vj5wxplpkhz4bmc0r2dbghnifznw6rm1jqjxqf6bmj23ap6qahq";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 747202966905F7917FB3B8F95228E026
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "0zmd3mkpz3cpclbasjjn8rrcffhsn2f00mw00jya3x259hrvvpcr";
        };
        max = fetchurl {
          # Size: 11.4 MB MD5: 77B086D125489CD74D05FD9ED1AA4883
          url = "${baseUrl}/max-${version}.qdz";
          sha256 = "12h6sgqqdjf929mmdis5wad85c5bjmnwlp8xqjxl3hhzd15x1xcd";
        };
        max10 = fetchurl {
          # Size: 325.2 MB MD5: 9B55655054A7EA1409160F27592F2358
          url = "${baseUrl}/max10-${version}.qdz";
          sha256 = "0xwvy7ja637qh7dbf64pxrhqhyr15ws9wdir1zfxwahdw0n1ril5";
        };
        stratixiv = fetchurl {
          # Size: 544.5 MB MD5: 9A8BA92290A4ABD5F658AF0ED6B314AA
          url = "${baseUrl}/stratixiv-${version}.qdz";
          sha256 = "08pf4aa068h1m1fhg8bjbkh3sxw8rhgr5h7gwlzjjh2p8dgqr41q";
        };
        stratixv = fetchurl {
          # Size: 2.9 GB MD5: 7A20672F48961BD91F20F23574FD7461
          url = "${baseUrl}/stratixv-${version}.qdz";
          sha256 = "0w115lsb3h2xlibg2c2qcw2rwigarv6569gn19xp3krk2h0i03p9";
        };
      };
    };

    # Updates are shared between editions. I.e. this update can be applied to
    # either lite or standard editions.
    updates = rec {
      version = "17.1.1.593";
      updateBaseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/17.1std.1/593/update";
      components = {
        quartus = fetchurl {
          # Size: 1.9 GB MD5: 70E8016EA12CF7835DFCD3B22B1E3153
          url = "${updateBaseUrl}/QuartusSetup-${version}-linux.run";
          sha256 = "1nk903prd6qs1v5dyyh1l227drk7m99zssp3dc8v4jq53fv9hsjs";
        };
      };
    };
  };

  v18 = rec {
    version = "18.1.0.625";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/18.1std/625/ib_installers";

    lite = {
      baseName = "altera-quartus-prime-lite";
      prettyName = "Quartus Prime Lite Edition";
      inherit version;
      components = {
        quartus = fetchurl {
          # Size: 2.0 GB MD5: 8A22E65F15B695E7967A292CAA7275F3
          url = "${baseUrl}/QuartusLiteSetup-${version}-linux.run";
          sha256 = "06d975f65f86290719407f92d6364487a713650388f583a8e2f251694bc45513";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB MD5: 47E17B9DCCE592AD248991660B0B3CD8
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "02e2a5ada4cdad78a1988508a98f8851c1a47ca82297ec4dc67b19b9414f52c1";
        };
        cyclone = fetchurl {
          # Size: 466.6 MB MD5: 09D346E4AE7AC403DF4F36563E6B7BFB
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "cb19bc70de45af52490f53b15931861949ce460cbcdf92aec4fd01192c957efd";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB MD5: 747202966905F7917FB3B8F95228E026
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "03f89491eeb1a9dafb8b9d244db34f4fe25da1a5fd38d07c499733444c456329";
        };
      };
    };

    standard = {
      baseName = "altera-quartus-prime-standard";
      prettyName = "Quartus Prime Standard Edition";
      inherit version;
      components = {
        quartus = fetchurl {
          # Size: 2.7 GB SHA1: f9e4ffca9d7cfe26b30873d17893a041f726cce3
          url = "${baseUrl}/QuartusSetup-${version}-linux.run";
          hash = "sha256-5bJWMmuwDq3Txkbihf6RhEoPrM3sMGwDKIuSDtxiKo8=";
        };
        modelsim = fetchurl {
          # Size: 1.1 GB SHA1: 128f18e1fe798786176108cbca3a21791d37f7ba
          url = "${baseUrl}/ModelSimSetup-${version}-linux.run";
          sha256 = "02e2a5ada4cdad78a1988508a98f8851c1a47ca82297ec4dc67b19b9414f52c1";
        };
        cyclone = fetchurl {
          # Size: 466.6 MB SHA1: 0063923ed4b3e12f706a5fb95ddce71fbb89d833
          url = "${baseUrl}/cyclone-${version}.qdz";
          sha256 = "cb19bc70de45af52490f53b15931861949ce460cbcdf92aec4fd01192c957efd";
        };
        cyclonev = fetchurl {
          # Size: 1.1 GB SHA1: be21e885ffd70321d926dbe269ee8c2ef7ad615e
          url = "${baseUrl}/cyclonev-${version}.qdz";
          sha256 = "03f89491eeb1a9dafb8b9d244db34f4fe25da1a5fd38d07c499733444c456329";
        };
      };
    };
  };

  v19 = rec {
    version = "19.1.0.670";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/19.1std/670/ib_installers";

    lite = {
      variant = "lite";
      inherit version baseUrl;
      quartusInstaller = "QuartusLiteSetup";
      
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusLiteSetup = "sha256-7lSUicFPagOFKzotboQh/kPfvw110sEpVEnMhjvefZc=";
        ModelSimSetup = "sha256-2fhBwSoNc2AiIGhhDcojv/askOn0iqosQpsyGVJ2O0g=";
      };
      devices = {
        arria_lite = "";
        cyclone = "";
        cyclone10lp = "";
        cyclonev = "sha256-S+Hfv6mUlt+TB6FrCerElb6PWS0HSzCpNh7A++S+HS8=";
        max = "";
        max10 = "";
      };
      
    };

    standard = {
      variant = "standard";
      inherit version baseUrl;
      quartusInstaller = "QuartusSetup";
      
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusSetup = "sha256-mvjYX/JyISs0NQRkQWO+IlX5+2VNtk5OLJYPOx7LWnI=";
        ModelSimSetup = "sha256-2fhBwSoNc2AiIGhhDcojv/askOn0iqosQpsyGVJ2O0g=";
      };
      devices = {
        cyclonev = "sha256-S+Hfv6mUlt+TB6FrCerElb6PWS0HSzCpNh7A++S+HS8=";
      };
      
    };
  };
  v20 = rec {
    version = "20.1.1.720";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/20.1std.1/720/ib_installers";

    lite = {
      variant = "lite";
      inherit version baseUrl;
      quartusInstaller = "QuartusLiteSetup";
      
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusLiteSetup = "sha256-c7CwFtQsvRGd2qFZ6l7f3KFFnCXrloRPvrGJMF4OV1Y=";
        ModelSimSetup = "";
      };
      devices = {
        arria_lite = "";
        cyclone = "";
        cyclone10lp = "";
        cyclonev = "sha256-Uz2KGuVouBuzaiLeNpp9IBF34yk58DG2r9PVen9SaoU=";
        max = "";
        max10 = "";
      };
      
    };

    standard = {
      variant = "standard";
      inherit version baseUrl;
      quartusInstaller = "QuartusSetup";
      
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusSetup = "";
        ModelSimSetup = "";
      };
      devices = {
        arria = "";
        arria10 = {
          arria10_part1 = "";
          arria10_part2 = "";
          arria10_part3 = "";
        };
        arriav = "";
        arriavgz = "";
        cyclone = "";
        cyclone10lp = "";
        cyclonev = "sha256-Uz2KGuVouBuzaiLeNpp9IBF34yk58DG2r9PVen9SaoU=";
        max = "";
        max10 = "";
        stratixiv = "";
        stratixv = "";
      };
      
    };
  };
  v21 = rec {
    version = "21.1.1.850";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/21.1std.1/850/ib_installers";

    lite = {
      variant = "lite";
      inherit version baseUrl;
      quartusInstaller = "QuartusLiteSetup";
      
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusLiteSetup = "sha256-6lUHQKL8LU70WeRTT1nMsGqaqjmvo9hWlbFQPBMl/0o=";
        QuestaSetup = "";
      };
      devices = {
        arria_lite = "";
        cyclone = "";
        cyclone10lp = "";
        cyclonev = "sha256-qH73W5zV4unIIhOxajT2gonpqpbiuqTZThCGvy4TFYo=";
        max = "";
        max10 = "";
      };
      
    };
  };
  v22 = rec {
    version = "22.1std.2.922";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/22.1std.2/922/ib_installers";

    lite = {
      variant = "lite";
      inherit version baseUrl;
      quartusInstaller = "QuartusLiteSetup";
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusLiteSetup = "sha256-gxo8y1umP/mt3aKbrRl5WjwTH4/8/p2tNzYUtq4gHR0=";
        QuestaSetup = "";
      };
      devices = {
        arria_lite = "";
        cyclone = "";
        cyclone10lp = "";
        cyclonev = "sha256-TN6EnXNZJoXt7gO+dx5c8zGYR+RxtYjEdKIQH8WjNSQ=";
        max = "";
        max10 = "";
      };
      
    };
  };
  v23 = rec {
    version = "23.1std.1.993";
    baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/23.1std.1/993/ib_installers";

    lite = {
      variant = "lite";
      inherit version baseUrl;
      quartusInstaller = "QuartusLiteSetup";
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusLiteSetup = "sha256-OCp2hZrfrfp1nASuVNWgg8/ODRrl67SJ+c6IWq5eWvY=";
        QuestaSetup = "sha256-Dne4MLFSGXUVLMd+JgiS/d5RX9t5gs6PEvexTssLdF4=";
      };
      devices = {
        arria_lite = "sha256-PNoc15Y5h+2bxhYFIxkg1qVAsXIX3IMfEQSdPLVNUp4=";
        cyclone = "sha256-2huDuTkXt6jszwih0wzusoxRvECi6+tupvRcUvn6eIA=";
        cyclone10lp = "sha256-i8VJKqlIfQmK2GWhm0W0FujHcup4RjeXughL2VG5gkY=";
        cyclonev = "sha256-HoNJkcD96rPQEZtjbtmiRpoKh8oni7gOLVi80c1a3TM=";
        max = "sha256-qh920mvu0H+fUuSJBH7fDPywzll6sGdmEtfx32ApCSA=";
        max10 = "sha256-XOyreAG3lYEV7Mnyh/UnFTuOwPQsd/t23Q8/P2p6U+0=";
      };
    };

    standard = {
      variant = "standard";
      inherit version baseUrl;
      quartusInstaller = "QuartusSetup";
      defaultInstalls = [];
      defaultDevices = [ "cyclonev" ];
      installers = {
        QuartusSetup = "sha256-wWM4DE4SCda+9bKWOY+RXez3ht0phBI/zeFKa5TzhrA=";
        QuestaSetup = "sha256-Dne4MLFSGXUVLMd+JgiS/d5RX9t5gs6PEvexTssLdF4=";
      };
      devices = {
        arria = "sha256-yl5Oo1X0eSlTHfVZnUnvytcP575g8n/wAZDbMjePU5c=";
        arria10 = "sha256-ahBSHA3Tq3Z3DXqXJlyBLKcdyXQzNRqpkdsUbQI4cEM=";
        arriav = "sha256-Rv8lxMBrx1aQOlalFT1+J2DBUYHGHn8twfj3dpLAv/o=";
        arriavgz = "sha256-eDC7rcL/WzXXECeSNDSvG1Heo+1kjr0fus1wxpcaebI=";
        cyclone = "sha256-2huDuTkXt6jszwih0wzusoxRvECi6+tupvRcUvn6eIA=";
        cyclone10lp = "sha256-i8VJKqlIfQmK2GWhm0W0FujHcup4RjeXughL2VG5gkY=";
        cyclonev = "sha256-HoNJkcD96rPQEZtjbtmiRpoKh8oni7gOLVi80c1a3TM=";
        max = "sha256-qh920mvu0H+fUuSJBH7fDPywzll6sGdmEtfx32ApCSA=";
        max10 = "sha256-XOyreAG3lYEV7Mnyh/UnFTuOwPQsd/t23Q8/P2p6U+0=";
        stratixiv = "sha256-1UoJDaaiOFshs7i9B/JdIkGUXF863jYiFNObNX71cJY=";
        stratixv = "sha256-Pi5MpgadLGqCr8xcsy80U5ZLpP1sI/dr8gNyTIvu+5k=";
      };
    };

    pro = {
      variant = "pro";
      version = "23.4.0.79";
      baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/23.4/79/ib_installers";
      
      quartusInstaller = "QuartusProSetup";
      defaultInstalls = [];
      defaultDevices = [ "cyclone10gx" ];
      installers = {
        QuartusProSetup = "sha256-Tcsn8WJ8XQG/irmQyMxu2oMgzc0Dj0llAK8UDZ92wpg=";
        QuestaSetup = "sha256-/9z7y5anAhycPb1xFSai75WUHLZJrwmCzvg70EpAWpI=";
      };
      installerParts = {
        QuartusProSetup = {
          QuartusProSetup-part2 = "sha256-slY1K8Vgbd6ntMOyPcrhlUgArgZY5qe15MwvdQsE3q0=";
        };
      };
      devices = {
        agilex7 = "sha256-3VP4amVgED/zZtEWFtsMuIV9ePpD0iOBw1J7CV+6nz8=";
        arria10 = "sha256-rCy03lujkuJmvKlyolKTU8UCYsaDwLQS7HlmDYGJXsM=";
        cyclone10gx = "sha256-azbOsqybxSNwtpp2dlPn0ZMrrFRekWmqtYgCC8kBkZw=";
        easicn5x = "sha256-sEpGbtuEBA/qv8ZOg3XqxfXzfsfMXByWqsDGIJyz0OU=";
        stratix10 = "sha256-oMYV2h/wDeoPEtd0mcw+Rsu2FNXYud1v0IepvJDifYA=";
      };
    };
  };
  v24 = {
    pro = {
      variant = "pro";
      version = "24.2.0.40";
      baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/24.2/40/ib_installers";

      quartusInstaller = "QuartusProSetup";
      defaultInstalls = [];
      defaultDevices = [ "cyclone10gx" ];

      installers = {
        QuartusProSetup = "sha256-/z05N2kaTzfbCbeWqKzutCbzhUI9cmgndhYV77g///k=";
        QuestaSetup = "sha256-9MrQ42v/nSFeN1UaSIjkAEM8xEcfm+dhqvEFKQ6migY=";
      };

      installerParts.QuartusProSetup = {
        QuartusProSetup-part2 = "sha256-6QMY2G4YKB+f7MH7rJNRyX3W1nanl06HOf3Y4RgT6lU=";
      };

      devices = let
        agilex_common = "sha256-6S0TUBxo7ceWGOkKgd8qmg9LJ44nrdcARHG4WN7OqnE=";
      in {
        agilex5 = { inherit agilex_common;
          agilex5 = "sha256-dvvpsgUiscJDwAT0zPNt/g+4eFbLDuqW6nvp18Ju5Aw=";
        };
        agilex7 = { inherit agilex_common;
          agilex7 = "sha256-8phcjTJH5W+xawvpkd7iBNWl5IyVsLvcDyZLGOFdM3s=";
        };
        arria10 = "sha256-QvPncnzF4Y1yjZpINqOdja52Fw37Z09xsrrMHd7L3Nk=";
        cyclone10gx = "sha256-p3/7RYlQDeNlxd70hovNZpc9gvG2qdiJbY1zT2r2M8Q=";
        easicn5x = "sha256-QRvmius45cMBkJP62mtWYvu7gsxWcavlt1oAW8e/gOg=";
        stratix10 = "sha256-akbCoK59jWeVkQIdle5NAEPpkd4dlyNETvmsEndvdmg=";
      };
    };
  };
}