{ }:

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

{
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
      version = "24.3.0.212";
      baseUrl = "https://downloads.intel.com/akdlm/software/acdsinst/24.3/212/ib_installers";

      quartusInstaller = "QuartusProSetup";
      defaultInstalls = [ ];
      defaultDevices = [ "cyclone10gx" ];

      installers = {
        QuartusProSetup = "sha256-lM/F013is6Bb1ablFXlK3mQeDHDO2EGWvTlab4LFQVk=";
        QuestaSetup = "sha256-M2nhS51GDcTvNg3dseeijNR+vc5BAIe11hRWB21MUuw=";
      };

      installerParts.QuartusProSetup = {
        QuartusProSetup-part2 = "sha256-nSdX1ip96IphMZSASjnrjGNRBJu3/66za5FLo3Boaq8=";
      };

      devices = let
        agilex_common = "sha256-FHbme4d8kWG9KBSxNn+7R6vgTVvxVfA4GDGWG48ytsw=";
      in {
        agilex5 = { inherit agilex_common;
          agilex5 = "sha256-wIJiOanc4ly7MGy5c0NgiW52IR9coxfYh6GRcvJCqR4=";
        };
        agilex7 = { inherit agilex_common;
          agilex7 = "sha256-TRivhruDwjEV5rZ8bGp1q9gnOOAQlgmnC6sHptj0pwM=";
        };
        arria10 = "sha256-xSIk0Af1AfPHejKlhFM3mpEfsGBieWC4l6TCv2tpd2k=";
        cyclone10gx = "sha256-2OQZ15ovHPPO4/wAKB6BjfskD6VLSDXf9ad4qqcx/VQ=";
        easicn5x = "sha256-oX3Tak9dYmb6bbTHQ1scjYREYNquiusHH0MWTAUUUWQ=";
        stratix10 = "sha256-7NuM6cWBKz6G0Tar5ixDwyAHZ7zanIlJCr0L4S14Wug=";
      };
    };
  };
}