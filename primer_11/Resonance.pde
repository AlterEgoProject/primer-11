// 共振モデル
class Resonance{
  float x; // 位置
  float v; // 速度
  float EIGEN; // 固有周波数
  float DELTA; // moveが呼ばれる時間間隔
  float K; // バネ係数
  
  // コンストラクタ(固有周波数,フレームレート,初期位置,初期速度)
  Resonance(float eigen, float frame_rate, float x_init, float v_init){
    if(eigen<=0){println("error!(constructor in Resonance) : EIGEN must be positive");System.exit(0);}
    x = x_init;
    v = v_init;
    EIGEN = eigen;
    DELTA = 1./frame_rate;
    K = pow(2*PI*eigen,2); // (2πf)^2
  }
  // 初期の位置と速度は省略可能
  Resonance(float eigen, float frame_rate){
    this(eigen,frame_rate,0.,0.);
  }
  
  void move(float external){
    v += (- K * x + external) * DELTA; // F = 弾性力 + 外力
    x += v * DELTA;
  }
  
  // 力学的エネルギー
  float energy(){
    return pow(v,2)/2 + K*pow(x,2)/2; // 1/2*mv^2 + 1/2*kx^2
  }
}
