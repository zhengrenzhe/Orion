import path from "path";
import HtmlWebpackPlugin from "html-webpack-plugin";
import HtmlWebpackHarddiskPlugin from "html-webpack-harddisk-plugin";
import InlineChunkHtmlPlugin from "inline-chunk-html-plugin";
import { Configuration } from "webpack";

const config: Configuration & { [key: string]: unknown } = {
  mode: "development",
  entry: {
    monaco: path.resolve(__dirname, "src/index.ts"),
  },
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "[name].bundle.js",
  },
  devtool: "inline-source-map",
  module: {
    rules: [
      {
        test: /\.ts$/,
        use: "ts-loader",
        exclude: /node_modules/,
      },
      {
        test: /\.s[ac]ss$/,
        use: ["style-loader", "css-loader", "sass-loader"],
      },
    ],
  },
  resolve: {
    extensions: [".ts", ".js", ".json"],
  },
  devServer: {
    contentBase: path.resolve(__dirname, "dist"),
  },
  plugins: [
    new HtmlWebpackPlugin({
      filename: "index.html",
      template: path.resolve(__dirname, "src/index.html"),
      chunks: ["monaco"],
      alwaysWriteToDisk: true,
      inject: "body",
      cache: false,
    }),
    new InlineChunkHtmlPlugin(HtmlWebpackPlugin, [/monaco/]),
    new HtmlWebpackHarddiskPlugin(),
  ],
};

export default config;