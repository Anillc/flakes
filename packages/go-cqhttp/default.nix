{ ffmpeg, writeText, buildGoModule, fetchurl }: buildGoModule {
    name = "go-cqhttp";
    version = "v1.0.0-beta7-fix2";
    src = fetchTarball {
        url = "https://github.com/Mrs4s/go-cqhttp/archive/refs/tags/v1.0.0-beta7-fix2.tar.gz";
        sha256 = "1g702xw3acpa2kaz0nzwq7kszwqqz7zrfmj9i4w9jnk1xhbwys62";
    };
    vendorSha256 = "sha256-SR18Ni8iVmD0zmjP1GKiJf5G2u6TKRANMfV0ezIO7y0=";
    patches = [
        (writeText "patch" ''
diff --git a/global/codec.go b/global/codec.go
index 9ff78cb..5f6f3e9 100644
--- a/global/codec.go
+++ b/global/codec.go
@@ -32,10 +32,10 @@ func EncoderSilk(data []byte) ([]byte, error) {
 
 // EncodeMP4 将给定视频文件编码为MP4
 func EncodeMP4(src string, dst string) error { //        -y 覆盖文件
-	cmd1 := exec.Command("ffmpeg", "-i", src, "-y", "-c", "copy", "-map", "0", dst)
+	cmd1 := exec.Command("${ffmpeg}/bin/ffmpeg", "-i", src, "-y", "-c", "copy", "-map", "0", dst)
 	err := cmd1.Run()
 	if err != nil {
-		cmd2 := exec.Command("ffmpeg", "-i", src, "-y", "-c:v", "h264", "-c:a", "mp3", dst)
+		cmd2 := exec.Command("${ffmpeg}/bin/ffmpeg", "-i", src, "-y", "-c:v", "h264", "-c:a", "mp3", dst)
 		return errors.Wrap(cmd2.Run(), "convert mp4 failed")
 	}
 	return err
diff --git a/global/codec/codec.go b/global/codec/codec.go
index f44120a..820a8a6 100644
--- a/global/codec/codec.go
+++ b/global/codec/codec.go
@@ -29,7 +29,7 @@ func EncodeToSilk(record []byte, tempName string, useCache bool) (silkWav []byte
 
 	// 2.转换pcm
 	pcmPath := path.Join(silkCachePath, tempName+".pcm")
-	cmd := exec.Command("ffmpeg", "-i", rawPath, "-f", "s16le", "-ar", "24000", "-ac", "1", pcmPath)
+	cmd := exec.Command("${ffmpeg}/bin/ffmpeg", "-i", rawPath, "-f", "s16le", "-ar", "24000", "-ac", "1", pcmPath)
 	if Debug {
 		cmd.Stdout = os.Stdout
 		cmd.Stderr = os.Stderr
        '')
    ];
}