module.exports = {
  entry: './src/static/index.js',
  output: {
    path: '/home/petar/Documents/Walter/dist',
    publicPath: '/assets/',
    filename: 'bundle.js',
  },
  module: {
    loaders: [
      {
        test: /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader: 'elm-webpack-loader?verbose=true&warn=true',
      },
    ],
  },
  resolve: {
    extensions: ['.js', '.elm'],
  },
  devServer: { inline: true },
};
