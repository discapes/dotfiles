with (import <nixpkgs> { });
mkShell {
  shellHook = "zsh";
  buildInputs = [
    fetch-scm
    afetch
    # hayabusa # proprietary
    owofetch
    maxfetch
    bunnyfetch
    yafetch
    leaf
    nitch
    screenfetch
    disfetch
    bfetch
    nerdfetch
    fet-sh
    profetch
    macchina
    # uwufetch # segfaults
    starfetch
    ramfetch
    pridefetch
    pfetch
    pfetch-rs
    neofetch
    hyfetch
    freshfetch
    fastfetch
  ];
}
